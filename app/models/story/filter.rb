class Story::Filter
  include ActiveModel::Model

  attr_accessor :country_id, :region_id, :city_id, :type_activity_id

  def to_h
    as_json.symbolize_keys
  end
end
