# == Schema Information
#
# Table name: guides
#
#  id                       :bigint(8)        not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  full_access              :boolean          default(FALSE), not null
#  debug_mode               :boolean          default(FALSE), not null
#  name_ru                  :string
#  name_en                  :string
#  surname_ru               :string
#  surname_en               :string
#  main_language_id         :integer
#  additional_languages_ids :integer          default([]), not null, is an Array
#  description_ru           :text
#  description_en           :text
#  main_phone               :string
#  additional_phone         :string
#  contact_email            :string
#  vk_link                  :string
#  instagram_link           :string
#  facebook_link            :string
#  city_id                  :integer
#  region_id                :integer
#  country_id               :integer
#  role_permissions         :hstore           not null
#  avatar                   :string
#

class Guide < ApplicationRecord
  TEMP_EMAIL_PREFIX = 'change@me'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte google_oauth2]

  mount_uploader :avatar, GuideAvatarUploader

  attr_accessor :role

  has_many :guide_identities, dependent: :destroy
  has_many :tours, dependent: :destroy
  has_many :tour_comments, through: :tours
  has_many :guide_company_permissions, dependent: :destroy
  has_many :guide_companies, through: :guide_company_permissions
  has_many :stories
  belongs_to :country, optional: true
  belongs_to :region, optional: true
  belongs_to :city, optional: true

  validates :email, presence: true, uniqueness: true
  # validates :country, presence: true, on: :update
  # validates :name_ru, presence: true, on: :update
  # validates :surname_ru, presence: true, on: :update

  after_save :set_defaults, on: :create

  def avalible_tours
    Tour.where(guide: self).or(Tour.where(guide_company: self.guide_companies))
  end

  def avalible_tour_comments
    TourComment.where(tour: avalible_tours).confirmed
  end

  def avalible_bookings
    Booking.by_tours(avalible_tours)
  end

  class << self
    def find_for_oauth(auth, signed_in_resource = nil)
      identity = GuideIdentity.find_for_oauth(auth)

      guide = signed_in_resource ? signed_in_resource : identity.guide

      if guide.nil?
        email = auth.info.email
        guide = Guide.find_by(email: email)

        if guide.nil?
          guide = Guide.new(
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0, 20]
          )
          guide.save!
        end
      end

      if identity.guide != guide
        identity.guide = guide
        identity.save!
      end

      guide
    end
  end

  #
  # TODO: Перенести в декоратор
  #
  def name_surname(locale)
    name = send('name_' + locale.to_s).html_safe rescue "Ошибка перевода"
    surname = send('surname_' + locale.to_s).html_safe rescue "Ошибка перевода"
    "#{name} #{surname}"
  end

  private

  def set_defaults
    set_languages
    set_default_coordinates
  end

  def set_languages
    ru_lng = Language.find_by(title_ru: 'Русский')
    en_lng = Language.find_by(title_ru: 'Английский')

    if @current_locale == :ru
      self.main_language_id = ru_lng.id
      self.additional_languages_ids << en_lng.id
    else
      self.main_language_id = en_lng.id
      self.additional_languages_ids << ru_lng.id
    end
  end

  def set_default_coordinates
    if @current_locale == :ru
      set_coordinates(City.find_by(title_ru: "Москва"))
    else
      set_coordinates(City.find_by(title_ru: "London"))
    end
  end

  def set_coordinates(city)
    self.city_id = city.id
    self.region_id = city.region_id
    self.country_id = city.country_id
  end
end
