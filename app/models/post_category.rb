# == Schema Information
#
# Table name: post_categories
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
#

class PostCategory < ApplicationRecord
  mount_uploader :avatar,       PostCategoryAvatarUploader
  mount_uploader :large_avatar, PostCategoryLargeAvatarUploader

  has_many :posts
end
