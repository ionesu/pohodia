class Site::PublicCityFacade

  attr_reader :city

  def initialize(city, current_tourist = nil, country = nil, region = nil, tour = nil, current_locale = :ru, current_page)
    @city = city
    @region = region
    @tour = tour
    @country = country
    @current_tourist = current_tourist
    @current_locale = current_locale
    @current_page = current_page
  end

  def base_object
    city
  end

  def tour_types
    TourType.all.select(:id, :title_en, :title_ru,  :avatar,
                                      :large_avatar).includes(:tour_categories).select(:id, :title_en, :title_ru)
  end

end