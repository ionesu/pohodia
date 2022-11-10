class Administrators::TourCategoriesController < AdministratorsController
  before_action :set_tour_category, only: [:edit, :update, :seo_data_items]
  before_action :get_tour_types

  def index
    @tour_categories = TourCategory.all.select(:id, :title_ru, :title_en, :slug_ru, :slug_en,
                                               :tour_type_id).includes(:tour_type).select(:id, :title_ru, :title_en)
  end

  def edit
  end

  def update
    result = Admin::STourCategory::Update.new(current_administrator, params[:id], permited_params).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def new
    @tour_category = TourCategory.new
  end

  def create
    result = Admin::STourCategory::Create.new(current_administrator, permited_params).main
    if result
      redirect_to edit_administrators_tour_category_path(result), notice: 'Запись успешно добавлена'
    else
      redirect_back(fallback_location: administrator_root_path)
    end
  end

  def seo_data_items;  end

  private

  def set_tour_category
    @tour_category = TourCategory.find(params[:id])
    @tour_type = @tour_category.tour_type
  end

  def permited_params
    params.require(:tour_category).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar,
                                          :large_avatar, :tour_type_id, :slug_ru, :slug_en, :meta_title_ru,
                                          :meta_title_en, :meta_description_ru,:meta_description_en,
                                          :meta_keywords_ru, :meta_keywords_en)
  end

  def get_tour_types
    @tour_types = TourType.all.collect { |type| [type.title_ru, type.id] }
  end
end