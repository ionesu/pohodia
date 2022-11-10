class StoriesFinder
  attr_reader :scope, :params

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    items = scope
    items = by_country_id(items)
    items = by_region_id(items)
    items = by_city_id(items)
    items = by_type_activity_id(items)
    items.distinct
  end

  protected

  def by_country_id(items)
    params[:country_id].present? ? items.where(country_id: params[:country_id]) : items
  end

  def by_region_id(items)
    params[:region_id].present? ? items.where(region_id: params[:region_id]) : items
  end

  def by_city_id(items)
    params[:city_id].present? ? items.where(city_id: params[:city_id]) : items
  end

  def by_type_activity_id(items)
    params[:type_activity_id].present? ? items.where(tour_category_id: params[:type_activity_id]) : items
  end
end
