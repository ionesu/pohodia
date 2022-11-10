module Geographical
  extend ActiveSupport::Concern

  included do
  	validates :geo_latitude, allow_blank: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  	validates :geo_longitude, allow_blank: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  end
end
