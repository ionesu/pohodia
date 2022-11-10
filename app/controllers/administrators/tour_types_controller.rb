class Administrators::TourTypesController < AdministratorsController
  before_action :set_tour_type, only: [:edit, :update, :tour_categories, :seo_data_items]

  def index
    @tour_types = TourType.all
  end

  def edit;end

  def update
    prm =  params.require(:tour_type).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                          :slug_ru, :slug_en, :meta_title_ru, :meta_title_en, :meta_description_ru,
                                          :meta_description_en, :meta_keywords_ru, :meta_keywords_en)
    result = Admin::STourType::Update.new(current_administrator, params[:id], prm).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def tour_categories
    @tour_categories = @tour_type.tour_categories.select(:id, :title_ru, :title_en, :slug_ru, :slug_en)
  end

  def seo_data_items;  end

  private

  def set_tour_type
    @tour_type = TourType.find(params[:id])
  end
end