# == Schema Information
#
# Table name: bookings
#
#  id                 :bigint(8)        not null, primary key
#  tour_price_item_id :integer
#  user_id            :bigint(8)
#  customer_email     :string(100)      not null
#  customer_phone     :string(25)
#  customer_name      :string(100)
#  customer_comment   :string(500)
#  terms_agree        :boolean          default(FALSE)
#  privacy_agree      :boolean          default(FALSE)
#  parties            :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  booking_status_id  :bigint(8)
#  tour_id            :integer
#

class Booking < ApplicationRecord
  belongs_to :booking_status
  belongs_to :tour_price_item, optional: true
  belongs_to :user, optional: true

  delegate :tour, :to => :tour_price_item, :allow_nil => true

  validates :customer_email, presence: true
  validates :parties, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :terms_agree, acceptance: { allow_nil: false, accept: true }
  validates :privacy_agree, acceptance: { allow_nil: false, accept: true }

  scope :by_tours, ->(tours) { where(tour_price_item: TourPriceItem.where(tour: tours)) }
  scope :by_guide, ->(guide) do
    if guide.is_a?(SGuide::GuideFacade)
      guide = guide.base_object
    end

    includes(tour_price_item: { tour: :guide })
      .where(tour_price_items: { tours: { guide: guide } })
  end

  after_commit :inform_on_create, on: :create
  after_commit :inform_on_update, on: :update

  after_initialize :set_defaults

  private

  def inform_on_create
    return if tour_price_item.nil?

    tour_price_item.update_attributes({ free_places: tour_price_item.free_places - 1 })
    begin
      BookingMailer.with(booking: self).booking_created.deliver_later
    rescue Exception => e
      Rails.logger.fatal "Failed send email booking.booking_created booking #{self.inspect}: #{e.inspect}"
    end
    begin
      BookingMailer.with(booking: self).booking_notification.deliver_later
    rescue Exception => e
      Rails.logger.fatal "Failed send email booking.booking_notification booking #{self.inspect}: #{e.inspect}"
    end
  end

  def inform_on_update
    begin
      BookingMailer.with(booking: self).booking_changed.deliver_later
    rescue Exception => e
      Rails.logger.fatal "Failed send email booking.booking_changed booking #{self.inspect}: #{e.inspect}"
    end
  end

  def set_defaults
    self.booking_status_id ||= BookingStatus.NEW.id
  end
end
