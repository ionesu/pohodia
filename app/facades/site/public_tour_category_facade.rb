class Site::PublicTourCategoryFacade

  attr_reader :tour_category, :country, :region, :city

  def initialize(tour_category, current_tourist = nil, current_locale = :ru, country = nil, region = nil, city = nil)
    @tour_category = tour_category
    @current_tourist = current_tourist
    @current_locale = current_locale
    @country = country
    @region = region
    @city = city
  end

  def base_object
    tour_category
  end

  def id
    base_object.id
  end

  def tours
    if country
      #
    elsif region
      Tour.where(region_id: region.id, tour_category_id: tour_category.id, global_status: 0)
    elsif city
      Tour.where(city_id: city.id, tour_category_id: tour_category.id, global_status: 0)
    end
  end

  def seo_data_item
    if country
      SeoDataItem.find_by(country_id: country.id, tour_category_id: tour_category.id, public_page_type: 1)
    elsif region
      SeoDataItem.find_by(region_id: region.id, tour_category_id: tour_category.id, public_page_type: 1)
    elsif city
      SeoDataItem.find_by(city_id: city.id, tour_category_id: tour_category.id, public_page_type: 1)
    end
  end
end