# == Schema Information
#
# Table name: tours
#
#  id                       :bigint(8)        not null, primary key
#  administrator_id         :integer
#  country_id               :integer
#  region_id                :integer
#  city_id                  :integer
#  tour_type_id             :integer
#  tour_category_id         :integer
#  avatar                   :string
#  complexity               :integer          default(1), not null
#  min_height               :integer          default(700), not null
#  max_height               :integer          default(1000), not null
#  length_of_route          :integer          default(1), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  large_avatar             :string
#  guide_id                 :integer
#  title_ru                 :string
#  title_en                 :string
#  description_ru           :string
#  description_en           :string
#  global_status            :integer          default("published"), not null
#  deleted_at               :datetime
#  guide_company_id         :integer          default(0)
#  minimum_age              :integer          default(5)
#  relocation_included      :boolean          default(FALSE), not null
#  confirmed                :boolean          default(FALSE)
#  many_days                :boolean
#  has_booking_without_date :boolean          default(FALSE)
#  has_booking              :boolean          default(FALSE)
#  price                    :integer
#  currency                 :string
#  external_url             :string
#  location                 :string
#  avatar_external_url      :string
#

class Tour < ApplicationRecord
  mount_uploader :avatar, TourAvatarUploader
  mount_uploader :large_avatar, TourLargeAvatarUploader

  has_many :tour_images

  #has_many :images, -> { where(removed: false) }, class_name: 'TourImage'
  def images
    tour_images.reject(&:removed)
  end

  has_many :tour_price_items
  has_many :tour_routes, -> { order(:time) }
  has_many :tour_options
  has_many :tour_comments, dependent: :destroy
  has_many :tour_discussions, dependent: :destroy
  has_many :users_tours
  has_many :users, through: :users_tours

  belongs_to :guide, optional: true
  belongs_to :guide_company, optional: true
  belongs_to :country
  belongs_to :region, optional: true
  belongs_to :city, optional: true
  belongs_to :tour_type
  belongs_to :tour_category

  alias price_items tour_price_items
  alias routes tour_routes
  alias options tour_options

  enum global_status: { published: 0, not_published: 1, deleted: 2 }

  def hide!
    self.deleted_at = DateTime.now
    self.global_status = 2
    save!(validate: false)
  end

  def restore!
    self.deleted_at = nil
    self.global_status = 1
    save!(validate: false)
  end

  ACTIVE = :active
  MODERATION = :moderation
  CORRECTION = :correction
  SUSPENDED = :suspended

  scope :with_associations, -> do
    includes(
      :tour_images, :tour_price_items, :tour_routes, :tour_options, :guide, :guide_company, :country, :region, :city,
      :tour_type, :tour_category, tour_comments: [:user, :tour_comment_photos]
    )
  end
  scope :not_deleted, -> { where.not(global_status: 2) }
  scope :deleted, -> { where(global_status: 2) }
  scope :publishable, -> { where(global_status: 0).confirmed }
  scope :confirmed, -> { where(confirmed: true) }

  scope :approve, -> { where(confirmed: true) }
  scope :censure, -> { where(confirmed: false).includes(:tour_discussions) }

  scope :active, -> { publishable }
  scope :moderation, -> { censure }
  scope :correction, -> { censure.where(tour_discussions: { confirmed: false }) }
  scope :suspended, -> { where(global_status: 2) }

  scope :by_period, ->(period) do
    where(tour_price_items: TourPriceItem.where(date_beginning: period.start_date..period.end_date))
  end

  scope :can_booking, -> do
    find_by_sql <<-SQL
      select tours.*
      from tours
      inner join tour_price_items
        on tour_price_items.tour_id = tours.id
        and tour_price_items.date_beginning > NOW()
      group by tours.id
      having count(tour_price_items.id) > 0
      union
      select *
      from tours
      where has_booking_without_date = true;
    SQL
  end

  validates :tour_category, presence: true
  validates :tour_type, presence: true
  validates :title_ru, presence: true

  validates :complexity, presence: true
  validates :min_height, presence: true
  validates :max_height, presence: true
  validates :length_of_route, presence: true
  validates :global_status, presence: true, on: :update

  before_validation do
    self.tour_type = tour_category.tour_type
  end

  before_create do
    self.tour_type = tour_category.tour_type
  end

  before_save do
    if self.min_height > self.max_height
      self.min_height, self.max_height = self.max_height, self.min_height
    end

    if has_booking_without_date?
      self.has_booking = true
    elsif tour_price_items.present?
      self.has_booking = true
    else
      self.has_booking = false
    end
  end

  include PgSearch::Model

  pg_search_scope :search_by_autocomplete,
                  :against => [
                    [:title_ru, 'A'], [:title_en, 'A'],
                    [:description_ru, 'B'], [:description_en, 'B']
                  ],
                  :associated_against => {
                    :tour_type => [
                      [:title_ru, 'A'], [:title_en, 'A'],
                      [:description_ru, 'B'], [:description_en, 'B']
                    ],
                    :tour_category => [
                      [:title_ru, 'A'], [:title_en, 'A'],
                      [:description_ru, 'B'], [:description_en, 'B']
                    ],
                    :country => [:title_ru, :title_en],
                    :region => [:title_ru, :title_en],
                    :city => [:title_ru, :title_en]
                  },
                  :using => {
                    :tsearch => {
                      :prefix => true
                      #, :dictionary => "english"
                    }
                  }

  ####################################################################
  # TO -> Decorator
  ####################################################################

  def smart_collect_for_select(collection, current_locale)
    return collection.collect { |item| [item.title_ru, item.id] } if current_locale == :ru
    collection.collect { |item| [item.title_en, item.id] } if current_locale == :en
  end

  def all_tour_categories(current_locale)
    if tour_type_id
      smart_collect_for_select(tour_type.tour_categories.select(:id, :title_ru, :title_en).order(:id), current_locale)
    else
      []
    end
  end

  def options_for_tour_owner(current_guide, current_locale)
    options = if current_guide
                avaible_companies(current_guide).collect do |permission|
                  [permission.guide_company.send('title' + '_' + current_locale.to_s),
                   permission.guide_company.id]
                end
              else
                []
              end

    options.unshift([(I18n.t ("all_pages.labels.you")), '0'])
  end

  #
  # доступные компании для размещения тура
  #
  def avaible_companies(current_guide)
    GuideCompanyPermission.where(guide_id: current_guide.id, full_access: true)
      .or(GuideCompanyPermission.where(guide_id: current_guide.id,
                                       access_to_tours: true,
                                       full_access: false))
      .includes(:guide_company)
  end

  ####################################################################
  # TO -> Decorator
  ####################################################################

  def filters_hash
    h = {}
    [
      :min_price, :max_price, :minimum_age, :route_duration,
      :date_start, :date_finish, :complexity, :relocation_included
    ].each { |f| h[f] = send(f) }
    h
  end

  def date_start
    tour_price_items.where(deleted: false).order(:id).first.try(:date_beginning).try(:strftime, '%Y-%m-%d')
  end

  def date_finish
    tour_price_items.where(deleted: false).order(:id).first.try(:date_completion).try(:strftime, '%Y-%m-%d')
  end

  def brief_name
    case I18n.locale
    when :ru
      "#{tour_category.title_ru} #{tour_type.title_ru} #{title_ru}"
    else
      "#{tour_category.title_en} #{tour_type.title_en} #{title_en}"
    end
  end

  def address_name
    case I18n.locale
    when :ru
      "#{country&.title_ru} #{region&.title_ru} #{city&.title_ru}".squish
    else
      "#{country&.title_en} #{region&.title_en} #{city&.title_en}".squish
    end
  end

  def full_name
    case I18n.locale
    when :ru
      "#{country.title_ru} #{region.title_ru} #{city.title_ru} #{tour_category.title_ru} #{tour_type.title_ru} #{title_ru}"
    else
      "#{country.title_en} #{region.title_en} #{city.title_en} #{tour_category.title_en} #{tour_type.title_en} #{title_en}"
    end
  end

  def valid_complexity?
    (1..5) === self.complexity
  end

  def min_price
    # price_items = get_all_tour_price_items
    # if price_items.size > 0
    #   price_items.first.price
    # else
    #   0
    # end
    prices.min || 0
  end

  def max_price
    # price_items = get_all_tour_price_items
    # if price_items.size > 0
    #   price_items.last.price
    # end

    prices.max
  end

  def custom_location=(location)
    city = City.find_by(title_ru: location)
    if city.blank?
      region = Region.find_by(title_ru: location)
      if region.blank?
        country = Country.find_by(title_ru: location)
        if country.present?
          self.country = country
        else
          self.location = location
        end
      else
        self.region = region
        self.country = country
      end
    else
      self.city = city
      self.region = city.region
      self.country = city.country
    end
  end

  def route_duration
    tour_routes.reject { |a| a.removed }.size
  end

  def duration
    get_all_tour_price_items.size
  end

  def confirmed_present
    confirmed? ? 'Потвержден' : 'Не потвержен'
  end

  def show_map?
    tour_routes.active.size > 1 && tour_routes.active.reject { |route| route.show_map? }.present?
  end

  private

  def prices
    tour_price_items.reject { |v| v.deleted }.map { |v| v.price }
  end

  # перенести в фасад
  def get_all_tour_price_items
    self.tour_price_items.where(deleted: false).order(:price)
  end

  # def to_xml(options = {})
  #   options[:indent] ||= 2
  #   xml = Builder::XmlMarkup.new(indent: options[:indent])
  #   xml.instruct! unless options[:skip_instruct]
  #   xml.level_one do
  #     xml.tag!(:second_level, 'content')
  #   end
  # end
end
