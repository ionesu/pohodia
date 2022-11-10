# == Schema Information
#
# Table name: story_images
#
#  id         :bigint(8)        not null, primary key
#  story_id   :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  removed    :boolean          default(FALSE)
#

class StoryImage < ApplicationRecord
  mount_uploader :image, StoryImageUploader
  belongs_to :story
end
