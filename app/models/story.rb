# == Schema Information
#
# Table name: stories
#
#  id               :bigint(8)        not null, primary key
#  title_ru         :string
#  title_en         :string
#  text_ru          :text
#  text_en          :text
#  user_id          :integer
#  administrator_id :integer
#  country_id       :integer
#  region_id        :integer
#  city_id          :integer
#  type_activity    :string
#  image            :string
#  large_image      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tour_category_id :integer
#  guide_id         :integer
#

class Story < ApplicationRecord
  mount_uploader :image, StoryAvatarUploader
  mount_uploader :large_image, StoryLargeAvatarUploader

  belongs_to :user, optional: true
  belongs_to :administrator, optional: true
  belongs_to :guide, optional: true
  belongs_to :country, optional: true
  belongs_to :city, optional: true
  belongs_to :region, optional: true
  belongs_to :tour_category, optional: true
  has_many :story_images
  has_many :images, -> { where(removed: false) }, class_name: 'StoryImage'
  has_many :story_comments

  def first_image
    if story_images.size > 0
      story_images.first
    end
  end
end
