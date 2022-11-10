# == Schema Information
#
# Table name: tour_options
#
#  id          :bigint(8)        not null, primary key
#  tour_id     :integer
#  title_ru    :string
#  title_en    :string
#  option_type :integer          default("included_in_price"), not null
#  removed     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TourOption < ApplicationRecord
  belongs_to :tour
  enum option_type: { included_in_price: 0, not_included_in_price: 1, equipment: 2 }

  scope :active, -> { where(removed: false) }
  scope :deleted, -> { where(removed: true) }
  scope :included_in_price, -> { where(option_type: :included_in_price) }
  scope :not_included_in_price, -> { where(option_type: :not_included_in_price) }
  scope :equipment, -> { where(option_type: :equipment) }

  validates :option_type, presence: true
  validates :title_ru, presence: true
  #validates :title_en, presence: true
end
