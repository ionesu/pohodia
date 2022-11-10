# == Schema Information
#
# Table name: tour_comment_photos
#
#  id              :bigint(8)        not null, primary key
#  tour_comment_id :bigint(8)
#  photo           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class TourCommentPhoto < ApplicationRecord
  belongs_to :tour_comment

  mount_uploader :photo, CommentPhotoUploader
end
