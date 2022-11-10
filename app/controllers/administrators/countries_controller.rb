class Administrators::CountriesController < AdministratorsController

  before_action :set_country, only: [:seo_data_items]

  def index
    @countries = Country.all
  end

  # добавить функционал
  def create
  end

  def edit
    @country = Country.find(params[:id])
  end

  def update
    prm = params.require(:country).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                          :iso_code, :slug_ru, :slug_en, :meta_title_ru, :meta_title_en,
                                          :meta_description_ru, :meta_description_en, :meta_keywords_ru, :meta_keywords_en,
                                          :guides_meta_title_ru, :guides_meta_title_en,
                                          :guides_meta_description_ru, :guides_meta_description_en, :guides_meta_keywords_ru,
                                          :guides_meta_keywords_en)
    result = Admin::SCountry::Update.new(current_administrator, params[:id], prm).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавить функционал
  def destroy
  end

  # регионы страны
  def regions
    @country = Country.find(params[:id])
    @regions = @country.regions.select(:id, :title_ru, :title_en, :slug_ru, :slug_en)
  end

  # города страны
  def cities
    @country = Country.find(params[:id])
    @cities = @country.cities.select(:id, :title_en, :title_ru, :slug_ru, :slug_en)
  end

  def seo_data_items
    @pages_for_tour_types = SeoDataItem.where(country_id: @country.id, public_page_type: 0).select(:id, :country_id, :tour_type_id, :public_page_type).includes(:tour_type) # страна -> типы туров (Армения -> пешие туры)
    @pages_for_tour_categories = SeoDataItem.where(country_id: @country.id, public_page_type: 1).select(:id, :country_id, :tour_type_id, :tour_category_id, :public_page_type).includes(:tour_type, :tour_category) # страна -> типы туров (Армения -> пешие туры -> восхождение)

    @all_tour_types = TourType.all.select(:id, :title_ru).order(:id).collect { |tour_type| [tour_type.title_ru, tour_type.id] }
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end
end