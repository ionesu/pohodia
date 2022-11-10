# == Schema Information
#
# Table name: story_comments
#
#  id         :bigint(8)        not null, primary key
#  story_id   :integer
#  user_id    :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoryComment < ApplicationRecord
  belongs_to :user
  belongs_to :story
  has_many :story_comment_photos
end
