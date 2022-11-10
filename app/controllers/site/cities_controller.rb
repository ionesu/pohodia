class Site::CitiesController < SiteController
  include TourFilterable

  before_action :set_city, only: [:show, :tour_type, :tour_category, :guides]

  # Австралия -> Центральный регион -> Сидней
  def show
    @country_selected = true
    @region_selected = true
    @city_selected = true
    @city = Site::PublicCityFacade.new(@city, nil, @current_locale, params[:page])
    @tour_filter = Tour::Filter.new(filter_params.merge(city_id: params[:id], country_id: @city.city.country_id, region_id: @city.city.region_id))
    @tours =
      ToursFinder
        .new(Tour.includes(:users_tours).publishable.where(id: Tour.can_booking), @tour_filter.to_h)
        .call
        .paginate(page: params[:page], per_page: 200)
  end

  # Австралия -> Центральный регион -> Сидней -> гиды
  def guides;
  end

  # Австралия -> центральный регион -> Сидней -> пешие туры
  def tour_type
    @tour_type = TourType.find(params[:tour_type_id])
    # @seo_data_item = SeoDataItem.find_by(city_id: @city.id, tour_type_id: @tour_type.id, public_page_type: 0)
  end

  # Австралия -> центральный регион > Сидней -> пешие туры -> восхождение
  def tour_category
    @tour_category = TourCategory.find(params[:tour_category_id])
    @tour_type = @tour_category.tour_type
    #@seo_data_item = SeoDataItem.find_by(region_id: @region.id, tour_category_id: @tour_category.id, public_page_type: 0)
  end

  private

  def set_city
    @city = City.find(params[:id])
    @region = @city.region
    @country = @city.country
  end
end