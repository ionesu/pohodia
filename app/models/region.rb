# == Schema Information
#
# Table name: regions
#
#  id                  :integer          not null, primary key
#  country_id          :integer          not null
#  title_ru            :string(150)
#  title_en            :string(150)
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
#  created_at          :datetime         default(Tue, 18 Sep 2018 07:34:09 UTC +00:00), not null
#  updated_at          :datetime         default(Tue, 18 Sep 2018 07:34:09 UTC +00:00), not null
#

class Region < ApplicationRecord

  mount_uploader :avatar,       CountryAvatarUploader
  mount_uploader :large_avatar, CountryLargeAvatarUploader

  belongs_to :country
  has_many :cities
  has_many :guide_companies
end
