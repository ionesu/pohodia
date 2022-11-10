class Guides::ToursController < GuidesController
  before_action :get_tour, only: [
    :edit, :update, :destroy, :restore, :add_images, :delete_image, :add_tour_route,
    :update_tour_route, :delete_tour_route, :add_tour_option, :update_tour_option,
    :delete_tour_option, :add_price_item, :update_price_item, :delete_price_item,
    :refresh_price_items, :refresh_options, :refresh_errors, :refresh_routes,
    :refresh_gallery, :refresh_base_info
  ]
  skip_before_action :authenticate_guide!

  def index
    @tours =
      ToursFinder
        .new(
          current_guide.avalible_tours.not_deleted.includes(:country, :city, :region, :tour_type, :tour_category),
          params.permit(:status)
        )
        .call

    respond_to do |format|
      format.html
      format.xml do
        content = @tours.as_json(
          only: [:id, :title_ru, :title_en, :complexity, :min_height, :max_height],
          root: true,
          include: { country: { only: [:id, :title_ru, :title_en] } }
        )

        render xml: content
      end
    end
  end

  def trash
    @tours =
      ToursFinder
        .new(
          current_guide.avalible_tours.deleted.includes(:country, :city, :region, :tour_type, :tour_category),
          params.permit(:status)
        )
        .call
  end

  def new
    @tour = Tour.new
    if params[:guide_company].present?
      guide_company = GuideCompany.find(params[:guide_company])
      @tour.guide_company = guide_company if guide_company.present?
    end
    @countries = smart_collect_for_select(Country.all.order(:id))
    @all_tour_types = TourType.all.order(:id).collect do |tour_type|
      [tour_type.title_ru,
       tour_type.id]
    end
  end

  def edit
  end

  #
  # CREATE TOUR
  #
  def create
    SGuide::TourPolicy.new(pundit_user).access_to_tours?
    tour_create = SGuide::STour::Create.new(current_guide, tour_create_params)
    response = tour_create.call
    @tour = tour_create.tour
    respond_to do |format|
      format.html do
        if response[:result]
          redirect_to_edit_tour
        else
          redirect_back(fallback_location: guide_root_path)
        end
      end
      format.js {}
      format.json do
        if response[:result]
          render json: { redirect: edit_guides_tour_path(response[:object]), data: response[:object] }, status: :ok
        else
          render json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity
        end
      end
    end
  end

  #
  # CREATE FROM XML
  #
  def create_xml
    import_request = ImportRequest.create!(content: params[:content])
    TourImportJob.perform_later(current_guide.id, import_request.id)
    redirect_to guides_tours_path(status: :active)
  end

  #
  # UPDATE TOUR
  #
  def update
    response = SGuide::STour::Update.new(current_guide, params[:id], tour_update_params).call
    respond_to do |format|
      format.html { response[:result] ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js {}
      format.json do
        response[:result] ?
          render(json: { refresh: refresh_base_info_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
          render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity)
      end
    end
  end

  def refresh_base_info
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  def destroy
    @tour.hide!
    redirect_back(fallback_location: guide_root_path)
  end

  def restore
    @tour.restore!
    redirect_back(fallback_location: guide_root_path)
  end

  # добавить изображение в галерею
  def add_images
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    prm = params[:tour][:images]
    response = SGuide::STour::AddImages.new(current_guide, @tour, prm).call
    respond_to do |format|
      format.html { response[:result] ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js {}
      format.json do
        response[:result] ?
          render(json: { refresh: refresh_gallery_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
          render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity)
      end
    end
  end

  #
  # TODO: В отдельный контроллер
  #
  # удалить изображение из галереи
  def delete_image
    @image = @tour.tour_images.find(params[:image_id])
    @image.removed = true
    @image.save

    respond_to do |format|
      format.html do
        if response[:result]
          redirect_back(fallback_location: guide_root_path)
        else
          redirect_to_edit_tour
        end
      end
    end
  end

  def refresh_gallery
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  #
  # TODO: В отдельный ресурс
  #
  # добавить нитку маршрута
  def add_tour_route
    response = SGuide::STour::AddTourRoute.new(current_guide, @tour, tour_route_params).call
    respond_to do |format|
      format.html do
        if response[:result]
          redirect_back(fallback_location: guide_root_path)
        else
          redirect_to_edit_tour
        end
      end
      format.js {}
      format.json do
        if response[:result]
          render(json: { refresh: refresh_routes_guides_tour_path(@tour), data: response[:object] }, status: :ok)
        else
          render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity)
        end
      end
    end
  end

  #
  # TODO: В отдельный ресурс
  #
  # обновить нитку маршрута
  def update_tour_route
    response = SGuide::STour::UpdateTourRoute.new(current_guide, tour_route_params).call
    respond_to do |format|
      format.html { response[:result] ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js {}
      format.json { response[:result] ?
                      render(json: { refresh: refresh_routes_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
                      render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity) }
    end
  end

  #
  # TODO: В отдельный ресурс
  #
  # удалить нитку маршрута
  def delete_tour_route
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    response = SGuide::STour::DeleteTourRoute.new(current_guide, params[:tour_route]).call
    respond_to do |format|
      format.html { response[:result] ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js {}
      format.json { response[:result] ?
                      render(json: { refresh: refresh_routes_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
                      render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity) }
    end
  end

  def refresh_routes
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  #
  # TODO: В отельный ресурс
  #
  # добавить опцию в блок опции, которые включены/не включены в стоимость
  def add_tour_option
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    response = SGuide::STour::AddTourOption.new(current_guide, @tour, tour_option_params).call
    respond_to do |format|
      format.html { response[:result] ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.json do
        if response[:result]
          render(json: { refresh: refresh_options_guides_tour_path(@tour), data: response[:object] }, status: :ok)
        else
          render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity)
        end
      end
    end
  end

  # обновить опцию из блока опций, которые включены/не включены в стоимость
  def update_tour_option
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    prm = params.require(:tour_option).permit(:title_ru, :title_en)
    response = SGuide::STour::UpdateTourOption.new(current_guide, params[:tour_option][:id], prm).call
    respond_to do |format|
      format.html { response[:result] == true ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js {}
      format.json { response[:result] == true ?
                      render(json: { refresh: refresh_options_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
                      render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity) }
    end
  end

  # удалить опцию из блока опций, которые включены/не включены в стоимость
  def delete_tour_option
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    response = SGuide::STour::DeleteTourOption.new(current_guide, params[:option]).call
    respond_to do |format|
      format.html { response[:result] == true ? redirect_back(fallback_location: guide_root_path) : redirect_to_edit_tour }
      format.js do
        @tour = TourFacade.new(@tour, current_guide, @current_locale)
        if response[:result] == true
          render(:refresh_options)
        else
          @elem_id = "form#tour_option_#{response[:object].id}"
          @errors = response[:errors]
          render(:refresh_errors)
        end
      end
      format.json { response[:result] == true ?
                      render(json: { refresh: refresh_options_guides_tour_path(@tour), data: response[:object] }, status: :ok) :
                      render(json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity) }
    end
  end

  def refresh_errors
    @errors = @tour.errors
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  def refresh_options
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  # добавление элемента в блок "даты и стоимость"
  def add_price_item
    prm = params
            .require(:tour_price_item)
            .permit(
              :date_beginning, :date_completion, :total_places, :free_places, :price, :currency
            )

    response = SGuide::STour::AddPriceItem.new(current_administrator, @tour, prm).call
    respond_to do |format|
      format.html do
        if response[:result] == true
          redirect_back(fallback_location: guide_root_path)
        else
          redirect_to_edit_tour
        end
      end
    end
  end

  # удаление элемента из блока "даты и стоимость"
  def delete_price_item
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    response = SGuide::STour::DeletePriceItem.new(current_administrator, params[:tour_price_item]).call
    respond_to do |format|
      format.html do
        if response[:result] == true
          redirect_back(fallback_location: guide_root_path)
        else
          redirect_to_edit_tour
        end
      end
    end
  end

  # обновление элемента из блока "даты и стоимость"
  def update_price_item
    SGuide::TourPolicy.new(pundit_user, @tour).access_to_tour?
    prm = params.require(:tour_price_item).permit(:date_beginning, :date_completion, :total_places, :free_places,
                                                  :price, :id)
    SGuide::STour::UpdatePriceItem.new(current_administrator, prm).call
    redirect_back(fallback_location: guide_root_path)
  end

  def refresh_price_items
    @tour = TourFacade.new(@tour, current_guide, @current_locale)
    respond_to do |format|
      format.js {}
    end
  end

  private

  #
  # В зависимости админ или гид перередиректнуть на соответсвующую страницу
  #
  def redirect_to_edit_tour
    if @admin
      redirect_to(edit_administrators_tour_path(@tour))
    else
      redirect_to(edit_guides_tour_path(@tour))
    end
  end

  #
  # Определить, админ ли совершает дейсивие
  #
  def indent
    if request.referrer&.include?('admin')
      @admin = true
    else
      @admin = false
    end
  end

  def tour_route_params
    params.require(:tour_route)
      .permit(
        :title_ru, :title_en, :description_ru, :description_en, :sorting_postion,
        :type_accomodation, :type_of_food, :distance, :time_hours, :image,
        :geo_latitude, :geo_longitude, :wifi_enabled, :electricity_enabled,
        :cellular_network_enabled, :id, :time
      )
  end

  def tour_option_params
    params.require(:tour_option).permit(:title_ru, :title_en, :option_type)
  end

  def get_tour
    indent
    if @admin
      @tour = Tour.find(params[:id])
      @current_guide = @tour.guide
    else
      @tour = current_guide.avalible_tours.find(params[:id])
    end
  end

  def tour_create_params
    params
      .require(:tour)
      .permit(
        :title_ru, :title_en, :description_ru, :description_en, :city_id, :region_id, :country_id, :complexity,
        :min_height, :max_height, :length_of_route, :tour_category_id, :guide_company_id, :many_days,
        :has_booking_without_date
      )
  end

  def tour_update_params
    params
      .require(:tour)
      .permit(
        :title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
        :tour_category_id, :complexity, :min_height, :max_height, :length_of_route,
        :guide_company_id, :minimum_age, :relocation_included,
        :has_booking_without_date, :price, :currency
      )
  end
end
