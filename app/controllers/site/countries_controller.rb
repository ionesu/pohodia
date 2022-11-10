class Site::CountriesController < SiteController
  include TourFilterable

  before_action :set_country, only: [:show, :tour_type, :tour_category, :guides]

  def index
    respond_to do |format|
      format.json do
        countries = CountriesFinder.new(Country.all.order(:id), { page: params[:page] })
        render json: countries
      end
      format.html do
        @page = Page.find_by(descriptor: 'all_countries')
        @countries = Country.all.order(:id).paginate(page: params[:page], per_page: 36)
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: @country
      end
      format.html do
        @country_selected = true
        @country = Site::PublicCountryFacade.new(@country, nil, @current_locale, params[:page])
        @tour_filter = Tour::Filter.new(filter_params.merge(country_id: params[:id]))
        @tours = ToursFinder
                   .new(Tour.includes(:users_tours).publishable.where(id: Tour.can_booking), @tour_filter.to_h)
                   .call
                   .paginate(page: params[:page], per_page: 200)
      end
    end
  end

  # Австралия -> гиды
  def guides;
  end

  # Австралия -> пешие туры
  def tour_type
    @tour_type = TourType.find(params[:tour_type_id])
    @tour_type = Site::PublicTourTypeFacade.new(@tour_type, nil, @current_locale, @country, nil, nil)
    @tours = Tour.where(country_id: @country.id, tour_type_id: @tour_type.base_object.id,
                        global_status: 0).paginate(page: params[:page], per_page: 10)

    @tour_filter = Tour::Filter.new(filter_params.merge(country_id: @country.id, tour_type_id: @tour_type.id))
  end

  # Австралия -> пешие туры -> восхождение
  def tour_category
    @tour_category = TourCategory.find(params[:tour_category_id])
    @tour_category = Site::PublicTourCategoryFacade.new(@tour_category, nil, @current_locale,
                                                        @country, nil, nil)
    @tours = Tour.where(country_id: @country.id, tour_category_id: @tour_category.base_object.id,
                        global_status: 0).paginate(page: params[:page], per_page: 10)

    @tour_filter = Tour::Filter.new(filter_params.merge(country_id: @country.id, tour_category_id: @tour_category.id))
  end

  private

  def set_country
    @country = Country.find(params[:id])
    set_meta_tags @country
  end
end