class Tour::Filter
  include ActiveModel::Model

  attr_accessor :period
  attr_accessor :price_start
  attr_accessor :price_finish
  attr_accessor :duration_from
  attr_accessor :duration_to
  attr_accessor :country_id
  attr_accessor :region_id
  attr_accessor :city_id
  attr_accessor :tour_category_id
  attr_accessor :tour_type_id
  attr_accessor :minimum_age
  attr_accessor :complexities
  attr_accessor :plane

  def to_h
    clear
    as_json.symbolize_keys
  end

  protected

  def clear
    self.complexities = complexities&.uniq&.compact
  end
end