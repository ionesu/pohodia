# == Schema Information
#
# Table name: tour_images
#
#  id               :bigint(8)        not null, primary key
#  tour_id          :integer
#  administrator_id :integer
#  guide_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  image            :string           not null
#  removed          :boolean          default(FALSE), not null
#

class TourImage < ApplicationRecord
  mount_uploader :image, TourImageUploader
  belongs_to :tour
end
