# == Schema Information
#
# Table name: tour_comments
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  tour_id    :bigint(8)
#  text       :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  confirmed  :boolean          default(FALSE)
#

class TourComment < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  has_many :tour_comment_photos, dependent: :destroy

  default_scope -> { order(:created_at) }

  scope :confirmed, -> { where(confirmed: true) }
  scope :not_confirmed, -> { where(confirmed: false) }
end
