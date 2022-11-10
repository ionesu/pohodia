# == Schema Information
#
# Table name: tour_discussions
#
#  id               :bigint(8)        not null, primary key
#  administrator_id :integer
#  tour_id          :integer
#  text             :text
#  confirmed        :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TourDiscussion < ApplicationRecord
  belongs_to :administrator
  belongs_to :tour

  def decline
    self.confirmed = false
    save
  end
end
