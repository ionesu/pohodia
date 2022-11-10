class Administrators::ToursController < AdministratorsController
  include TourRouteHelper
  before_action :check_permissions
  before_action :get_tour, only: [:edit, :update, :confirm]

  def index
    @tours = ToursFinder
               .new(
                 Tour.all.includes(:country, :city, :region, :tour_type, :tour_category),
                 filter_params
               )
               .call
  end

  def cities
    @cities = @region.cities.select(:id, :title_en, :title_ru, :slug_en, :slug_ru)
  end

  def edit
    @current_guide = @tour.guide
    @countries = Country.all.select(:id, :title_ru).order(:id).collect { |country| [country.title_ru, country.id] }
    @all_tour_types = TourType.all.select(:id, :title_ru).order(:id).collect { |tour_type| [tour_type.title_ru, tour_type.id] }
    @all_tour_categories = @tour.tour_type_id ? @tour.tour_type.tour_categories.select(:id, :title_ru).order(:id).collect { |category| [category.title_ru, category.id] } : []
    @tour_images = @tour.tour_images
    @tour_price_item = TourPriceItem.new(date_beginning: Date.today)
    @tour_price_items = @tour.tour_price_items.order(:id)
    @new_tour_route = TourRoute.new(type_accomodation: nil, type_of_food: nil, distance: nil, time_hours: nil)
    @tour_routes = @tour.tour_routes.where(removed: false).order(:id)
    @removed_tour_routes = @tour.tour_routes.where(removed: true).order(:id)
  end

  def update
    prm = params.require(:tour)
            .permit(
              :title, :description, :avatar, :large_avatar, :tour_category_id, :complexity,
              :min_height, :max_height, :length_of_route
            )
    result = Admin::STour::Update.new(current_administrator, params[:id], prm).main
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def new
    @tour = Tour.new
    @countries = Country.all.select(:id, :title_ru).order(:id).collect { |country| [country.title_ru, country.id] }
    @all_tour_types = TourType.all.select(:id, :title_ru).order(:id).collect { |tour_type| [tour_type.title_ru, tour_type.id] }
  end

  def create
    prm = params.require(:tour)
            .permit(
              :title, :description, :city_id, :complexity, :min_height, :max_height,
              :length_of_route, :tour_category_id
            )
    result = Admin::STour::Create.new(current_administrator, prm).main
    if result
      redirect_to edit_administrators_tour_path(result)
    else
      redirect_back(fallback_location: administrator_root_path)
    end
  end

  def destroy
    if Admin::STour::Destroy.new(current_administrator, params[:id]).call
      redirect_back(fallback_location: administrator_root_path)
    else
      redirect_to edit_administrators_tour_path(params[:id])
    end
  end

  def confirm
    @tour.update(confirmed: true)
    ToursMailer.with(tour: @tour).tour_moderation.deliver_later
    redirect_to edit_administrators_tour_path(@tour)
  end

  def add_images
    prm = params[:tour][:images]
    Admin::STour::AddImages.new(current_administrator, params[:id], prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

  def remove_image
    Admin::STour::RemoveImage.new(current_administrator, params[:id], params[:image_id]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  def restore_image
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавление опции которая включена в стоимость
  def add_included_in_price_option
    Admin::STour::AddIncludedInPriceOption.new(current_administrator, params[:id], params[:tour][:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # удаление опции которая включена в стоимость
  def remove_included_in_price_option
    Admin::STour::RemoveIncludedInPriceOption.new(current_administrator, params[:id], params[:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавление опции которая НЕ включена в стоимость
  def add_not_included_in_price_option
    Admin::STour::AddNotIncludedInPriceOption.new(current_administrator, params[:id], params[:tour][:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # удаление опции которая НЕ включена в стоимость
  def remove_not_included_in_price_option
    Admin::STour::RemoveNotIncludedInPriceOption.new(current_administrator, params[:id], params[:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавить опцию необходимого снаряжения
  def add_equipment
    Admin::STour::AddEquipment.new(current_administrator, params[:id], params[:tour][:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # удалить опцию необходимого снаряжения
  def remove_equipment
    Admin::STour::RemoveEquipment.new(current_administrator, params[:id], params[:option]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавление элемента в блок "даты и стоимость"
  def add_price_item
    prm = params.require(:tour_price_item).permit(:date_beginning, :date_completion, :total_places, :free_places,
                                                  :price)
    Admin::STour::AddPriceItem.new(current_administrator, params[:id], prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # удаление элемента из блока "даты и стоимость"
  def remove_price_item
    Admin::STour::RemovePriceItem.new(current_administrator, params[:tour_price_item]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # обновление элемента из блока "даты и стоимость"
  def update_price_item
    prm = params.require(:tour_price_item).permit(:date_beginning, :date_completion, :total_places, :free_places,
                                                  :price, :id)
    Admin::STour::UpdatePriceItem.new(current_administrator, prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # добавить нитку маршрута
  def add_tour_route
    prm = params.require(:tour_route).permit(:title, :description, :sorting_postion, :type_accomodation, :type_of_food,
                                             :distance, :time_hours, :image, :geo_latitude, :geo_longitude,
                                             :wifi_enabled, :electricity_enabled, :cellular_network_enabled)
    Admin::STour::AddTourRoute.new(current_administrator, params[:id], prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # обновить нитку маршрута
  def update_tour_route
    prm = params.require(:tour_route).permit(:title, :description, :sorting_postion, :type_accomodation, :type_of_food,
                                             :distance, :time_hours, :image, :geo_latitude, :geo_longitude,
                                             :wifi_enabled, :electricity_enabled, :cellular_network_enabled, :id)
    Admin::STour::UpdateTourRoute.new(current_administrator, prm).main
    redirect_back(fallback_location: administrator_root_path)
  end

  # удалить нитку маршрута
  def remove_tour_route
    Admin::STour::RemoveTourRoute.new(current_administrator, params[:tour_route]).main
    redirect_back(fallback_location: administrator_root_path)
  end

  private

  def filter_params
    params.permit(:status)
  end

  def get_tour
    @tour = Tour.find(params[:id])
    @tour_facade = TourFacade.new(@tour, nil, @current_locale)
  end

  def check_permissions
    #unless current_administrator.role_permissions['tours'] == 'true' or current_administrator.full_access
    #  render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    #end
  end
end