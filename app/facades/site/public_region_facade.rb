class Site::PublicRegionFacade

  attr_reader :region

  def initialize(region, current_tourist = nil, country = nil,  tour = nil, current_locale = :ru, current_page)
    @region = region
    @tour = tour
    @country = country
    @current_tourist = current_tourist
    @current_locale = current_locale
    @current_page = current_page
  end

  def base_object
    region
  end

  def cities
    region.cities.order(:id).select(:id, :title_ru, :title_en,  :avatar,
                                      :large_avatar).paginate(page: @current_page, per_page: 240)
  end

  def tour_types
    TourType.all.select(:id, :title_en, :title_ru,  :avatar,
                                      :large_avatar).includes(:tour_categories).select(:id, :title_en, :title_ru)
  end

end