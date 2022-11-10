class Site::PublicCountryFacade
  attr_reader :country

  def initialize(country, current_tourist = nil, tour = nil, current_locale = :ru, current_page)
    @country = country
    @tour = tour
    @current_tourist = current_tourist
    @current_locale = current_locale
    @current_page = current_page
  end

  def base_object
    country
  end

  def regions
    country.regions.order(:id)
      .select(:id, :title_ru, :title_en, :avatar, :large_avatar)
      .paginate(page: @current_page, per_page: 240)
  end

  def tour_types
    TourType.all.select(:id, :title_en, :title_ru, :avatar, :large_avatar)
      .includes(:tour_categories).select(:id, :title_en, :title_ru)
  end

  def seo_data_item
    SeoDataItem.find_by(country_id: country.id, public_page_type: 1)
  end
end