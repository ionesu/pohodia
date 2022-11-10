class Administrators::RegionsController < AdministratorsController

  before_action :get_region, only: [:edit, :cities, :update, :seo_data_items]

  def cities
    @cities = @region.cities.select(:id, :title_en, :title_ru, :slug_en, :slug_ru)
  end

  def edit
  end

  def update
    prm =  params.require(:region).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                          :iso_code, :slug_ru, :slug_en, :meta_title_ru, :meta_title_en,
                                          :meta_description_ru, :meta_description_en, :meta_keywords_ru, :meta_keywords_en)
    result = Admin::SRegion::Update.new(current_administrator, params[:id], prm).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def seo_data_items;  end

  private

  def get_region
    @region = Region.find(params[:id])
    @country = @region.country
  end
end