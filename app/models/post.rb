# == Schema Information
#
# Table name: posts
#
#  id                  :bigint(8)        not null, primary key
#  title_ru            :string           not null
#  title_en            :string           not null
#  lead_ru             :text
#  lead_en             :text
#  post_category_id    :integer          not null
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
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Post < ApplicationRecord
  mount_uploader :avatar, PostAvatarUploader
  mount_uploader :large_avatar, PostLargeAvatarUploader

  belongs_to :post_category

  class << self
    def by_language(language)
      language.eql?(:en) ? where.not(title_en: '', lead_en: '', description_en: '') : all
    end
  end
end
