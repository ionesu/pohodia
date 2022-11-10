# == Schema Information
#
# Table name: booking_statuses
#
#  id       :bigint(8)        not null, primary key
#  title_ru :string(100)
#  title_en :string(100)
#  code     :string(25)
#

class BookingStatus < ApplicationRecord

  has_many :bookings
  
  def self.NEW
  	self.where(code: 'new').first
  end
  
  def self.CANCELED
  	self.where(code: 'canceled').first
  end
  
  def self.ACCEPTED
  	self.where(code: 'accepted').first
  end
  
  def self.CONFIRMED
  	self.where(code: 'confirmed').first
  end
  
  def self.COMPLETED
  	self.where(code: 'completed').first
  end
  
end
