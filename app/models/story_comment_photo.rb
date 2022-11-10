# == Schema Information
#
# Table name: story_comment_photos
#
#  id               :bigint(8)        not null, primary key
#  story_comment_id :integer          not null
#  photo            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StoryCommentPhoto < ApplicationRecord
  belongs_to :story_comment

  mount_uploader :photo, CommentPhotoUploader
end
