# == Schema Information
#
# Table name: tour_price_items
#
#  id              :bigint(8)        not null, primary key
#  tour_id         :integer
#  date_beginning  :date
#  date_completion :date
#  total_places    :integer          default(1), not null
#  free_places     :integer          default(1), not null
#  price           :integer          default(100), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted         :boolean          default(FALSE), not null
#  currency        :string
#

class TourPriceItem < ApplicationRecord
  belongs_to :tour
  has_many :bookings

  scope :active, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  # validates :total_places, :free_places, :price, :currency, presence: true

  before_save do
    self.free_places = 0 if free_places < 0

    if date_beginning.present?
      if self.date_beginning > self.date_completion
        self.date_beginning, self.date_completion = self.date_completion, self.date_beginning
      end
    end
  end

  CURRENCIES = %w(USD EUR RUB)

  def actual?
    return false unless date_beginning.present?

    date_beginning > Date.today && (total_places - free_places) > 0
  end

  def new_booking
    return if free_places == 0
    booking = bookings.build
    if @current_user.present?
      booking.user = @current_user
      booking.customer_email = @current_user.email
    end
    booking
  end
end
