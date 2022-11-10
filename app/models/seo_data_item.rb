# == Schema Information
#
# Table name: seo_data_items
#
#  id                  :bigint(8)        not null, primary key
#  country_id          :integer
#  region_id           :integer
#  city_id             :integer
#  tour_type_id        :integer
#  tour_category_id    :integer
#  public_page_type    :integer
#  image               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  large_image         :string
#  text_above_ru       :text
#  text_above_en       :text
#  text_below_ru       :text
#  text_below_en       :text
#  meta_title_ru       :string
#  meta_title_en       :string
#  meta_description_ru :text
#  meta_description_en :text
#  meta_keywords_ru    :string
#  meta_keywords_en    :string
#

class SeoDataItem < ApplicationRecord
  mount_uploader :image,       SeoDataItemImageUploader
  mount_uploader :large_image, SeoDataItemLargeImageUploader

  belongs_to :tour_type, required: false
  belongs_to :tour_category, required: false
  belongs_to :country, required: false

  # public_page_type
  # 0 -- Страна -> тип тура
  # SeoDataItem.find_by(country_id: @country.id, public_page_type: 0)
  #
  #
  # 1 -- Страна -> тип тура -> категория тура
  # вложенность: /все страны/ Армения/пешие туры/восхождение
end
