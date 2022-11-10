# == Schema Information
#
# Table name: tour_route_points
#
#  id            :bigint(8)        not null, primary key
#  tour_route_id :integer          not null
#  geo_latitude  :string
#  geo_longitude :string
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class TourRoutePoint < ApplicationRecord
  include Geographical

  belongs_to :tour_route

  validates :position, numericality: { only_integer: true, greater_than: 0 }

  before_validation :init_position

  protected

  def init_position
    if self.position.blank?
      last_point = tour_route.last_point_with_position

      if last_point.present?
        self.position = last_point.position + 1
      else
        self.position = 1
      end
    end
  end
end
