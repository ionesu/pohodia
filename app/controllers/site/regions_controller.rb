class Site::RegionsController < SiteController
  include TourFilterable

  before_action :set_region, only: [:show, :tour_type, :tour_category, :guides]

  # Австралия -> центральный регион
  def show
    @country_selected = true
    @region_selected = true
    @region = Site::PublicRegionFacade.new(@region, nil, @current_locale, params[:page])
    @tour_filter = Tour::Filter.new(filter_params.merge(region_id: params[:id], country_id: @region.region.country_id))
    @tours =
      ToursFinder
        .new(Tour.includes(:users_tours).publishable.where(id: Tour.can_booking), @tour_filter.to_h)
        .call
        .paginate(page: params[:page], per_page: 200)
  end

  # Австралия -> центральный регион -> гиды
  def guides;
  end

  # Австралия -> центральный регион -> пешие туры
  def tour_type
    @country_selected = true
    @region_selected = true
    @tour_type = TourType.find(params[:tour_type_id])
    @tour_filter = Tour::Filter.new(
      filter_params.merge(region_id: params[:id], country_id: @region.country_id, tour_type_id: @tour_type.id)
    )
    @region = Site::PublicRegionFacade.new(@region, nil, @current_locale, params[:page])

    @tours =
      ToursFinder
        .new(Tour.includes(:users_tours).publishable.where(id: Tour.can_booking), @tour_filter.to_h)
        .call
        .paginate(page: params[:page], per_page: 200)

    render template: 'site/regions/show'
  end

  # Австралия -> центральный регион -> пешие туры -> восхождение
  def tour_category
    @tour_category = TourCategory.find(params[:tour_category_id])
    @tour_type = @tour_category.tour_type
    #@seo_data_item = SeoDataItem.find_by(region_id: @region.id, tour_category_id: @tour_category.id, public_page_type: 0)
  end

  private

  def set_region
    @region = Region.find(params[:id])
    @country = @region.country
  end
end