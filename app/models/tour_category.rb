# == Schema Information
#
# Table name: tour_categories
#
#  id                  :bigint(8)        not null, primary key
#  title_ru            :string           not null
#  title_en            :string           not null
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
#  tour_type_id        :integer
#

class TourCategory < ApplicationRecord

  mount_uploader :avatar,       TourCategoryAvatarUploader
  mount_uploader :large_avatar, TourCategoryLargeAvatarUploader

  belongs_to :tour_type
  has_many :tours
  has_many :seo_data_items
end
