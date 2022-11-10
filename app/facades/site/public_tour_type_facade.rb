class Site::PublicTourTypeFacade

  attr_reader :tour_type, :country, :region, :city

  def initialize(tour_type, current_tourist = nil, current_locale = :ru, country = nil, region = nil, city = nil)
    @tour_type = tour_type
    @current_tourist = current_tourist
    @current_locale = current_locale
    @country = country
    @region = region
    @city = city
  end

  def base_object
    tour_type
  end

  def id
    base_object.id
  end

  def tour_categories
    tour_type.tour_categories.select(:id, :title_ru, :title_en, :avatar).order(:id)
  end

  def seo_data_item
    if country
      SeoDataItem.find_by(country_id: country.id, tour_type_id: tour_type.id, public_page_type: 1)
    elsif region
      SeoDataItem.find_by(region_id: region.id, tour_type_id: tour_type.id, public_page_type: 1)
    elsif city
      SeoDataItem.find_by(city_id: city.id, tour_type_id: tour_type.id, public_page_type: 1)
    end
  end
end