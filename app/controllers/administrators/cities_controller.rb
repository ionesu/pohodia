class Administrators::CitiesController < AdministratorsController

  before_action :get_city, only: [:edit, :update, :seo_data_items]

  def edit;end

  def update
    prm =  params.require(:city).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                        :iso_code, :slug_ru, :slug_en, :meta_title_ru, :meta_title_en,
                                        :meta_description_ru, :meta_description_en, :meta_keywords_ru, :meta_keywords_en)
    result = Admin::SCity::Update.new(current_administrator, params[:id], prm).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def seo_data_items

  end

  private

  def get_city
    @city    = City.find(params[:id])
    @country = @city.country
    @region  = @city.region
  end
end