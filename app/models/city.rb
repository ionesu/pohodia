# == Schema Information
#
# Table name: cities
#
#  id                  :integer          not null, primary key
#  country_id          :integer          not null
#  important           :boolean          not null
#  region_id           :integer
#  title_ru            :string(150)
#  area_ru             :string(150)
#  region_ru           :string(150)
#  title_en            :string(150)
#  area_en             :string(150)
#  region_en           :string(150)
#  description_ru      :text
#  description_en      :text
#  avatar              :string
#  large_avatar        :string
#  slug_ru             :string
#  slug_en             :string
#  meta_title_ru       :string
#  meta_title_en       :string
#  meta_description_ru :text
#  meta_description_en :text
#  meta_keywords_ru    :string
#  meta_keywords_en    :string
#  iso_code            :string
#  created_at          :datetime         default(Tue, 18 Sep 2018 07:34:12 UTC +00:00), not null
#  updated_at          :datetime         default(Tue, 18 Sep 2018 07:34:12 UTC +00:00), not null
#

class City < ApplicationRecord
  mount_uploader :avatar, CityAvatarUploader
  mount_uploader :large_avatar, CityLargeAvatarUploader

  scope :by_country, ->(country) { where(country: country) }
  scope :without_region, -> { where(region: nil) }

  has_many :guide_companies

  belongs_to :country
  belongs_to :region
end
