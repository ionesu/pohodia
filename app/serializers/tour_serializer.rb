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

class TourSerializer < ActiveModel::Serializer
  attributes :id, :title_ru, :description_ru, :complexity, :min_height, :max_height, :length_of_route, :avatar,
             :minimum_age, :external_url, :tour_routes, :tour_price_items, :images, :tour_comments, :tour_options
end
