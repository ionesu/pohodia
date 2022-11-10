# == Schema Information
#
# Table name: tour_routes
#
#  id                       :bigint(8)        not null, primary key
#  tour_id                  :integer          not null
#  sorting_postion          :integer          default(0), not null
#  type_accomodation        :integer          default("accomodation_tent"), not null
#  type_of_food             :integer          default("food_personal"), not null
#  distance                 :integer          default(0), not null
#  time_hours               :integer          default(0), not null
#  image                    :string
#  geo_latitude             :string
#  geo_longitude            :string
#  wifi_enabled             :boolean          default(FALSE), not null
#  electricity_enabled      :boolean          default(FALSE), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  removed                  :boolean          default(FALSE), not null
#  cellular_network_enabled :boolean          default(FALSE), not null
#  title_ru                 :string
#  title_en                 :string
#  description_ru           :text
#  description_en           :text
#  time                     :time
#

class TourRoute < ApplicationRecord
  include Geographical

  default_scope { order(:time) }

  belongs_to :tour

  has_many :tour_route_points, -> { order(:position) }

  mount_uploader :image, TourRouteImageUploader

  scope :active, -> { where(removed: false) }

  # проживание
  enum type_accomodation: {
    accomodation_tent: 0, # палатка
    accomodation_guest_house: 1, # гостевой дом
    accomodation_hut: 2, # хижина
    accomodation_apartment: 3, # квартира
    accomodation_hostel: 4, # хостел
    hotel_1_star: 5, # отель 1 звезда
    hotel_2_star: 6,
    hotel_3_star: 7,
    hotel_4_star: 8,
    hotel_5_star: 9,
    accomodation_yacht: 10,
    accomodation_other: 11,
    accomodation_not: 12
  }

  # питание
  enum type_of_food: {
    food_personal: 0, # личное
    food_1_meals: 1, # 1 раз в день
    food_2_meals: 2,
    food_3_meals: 3,
    food_cafe: 4, # кафе
    food_other: 5,
    food_not: 6
  }

  # validates :tour, presence: true
  validates :title_ru, presence: true
  #validates :title_en, presence: true
  # validates :sorting_postion, presence: true
  # validates :type_accomodation, presence: true
  # validates :type_of_food, presence: true
  # validates :distance, presence: true
  # validates :time_hours, presence: true
  #validates :wifi_enabled, presence: true
  #validates :electricity_enabled, presence: true
  #validates :removed, presence: true
  #validates :cellular_network_enabled, presence: true

  def point_with_position
    tour_route_points.where.not(position: nil)
  end

  def last_point_with_position
    point_with_position.last
  end

  def presense
    attributes.merge(tour_route_points: tour_route_points.map { |point| point.attributes })
  end

  def show_map?
    geo_latitude.present? && geo_longitude.present?
  end
end
