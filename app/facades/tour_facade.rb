class TourFacade < BaseFacade

  attr_reader :tour
  # возможно нужно подключить хелпер

  def initialize(tour, current_guide = nil, current_locale = :ru)
    @tour = tour
    @current_guide = current_guide
    @current_locale = current_locale
  end

  def base_object
    tour
  end

  def many_days?
    tour.many_days
  end

  def min_price
    tour.min_price
    #price_items = get_tour_price_items
    #if price_items.size > 0
    #  price_items.first.price
    #end
  end

  def max_price
    tour.max_price
    #price_items = get_tour_price_items
    #if price_items.size > 0
    #  price_items.last.price
    #end
  end

  #
  # @deprecated
  #
  # типы проживания для селекта
  def valid_types_accomodation
    [
      [(I18n.t 'models.tour_route.types_accomodation.tent'), '0'],
      [(I18n.t 'models.tour_route.types_accomodation.guest_house'), '1'],
      [(I18n.t 'models.tour_route.types_accomodation.hut'), '2'],
      [(I18n.t 'models.tour_route.types_accomodation.apartment'), '3'],
      [(I18n.t 'models.tour_route.types_accomodation.hostel'), '4'],
      [(I18n.t 'models.tour_route.types_accomodation.hotel_1_star'), '5'],
      [(I18n.t 'models.tour_route.types_accomodation.hotel_2_star'), '6'],
      [(I18n.t 'models.tour_route.types_accomodation.hotel_3_star'), '7'],
      [(I18n.t 'models.tour_route.types_accomodation.hotel_4_star'), '8'],
      [(I18n.t 'models.tour_route.types_accomodation.hotel_5_star'), '9'],
      [(I18n.t('models.tour_route.types_accomodation.accomodation_yacht')), '10'],
      [(I18n.t('models.tour_route.types_accomodation.accomodation_other')), '11'],
      [(I18n.t('models.tour_route.types_accomodation.accomodation_not')), '12'],
    ]
  end

  # @deprecated
  # типы питания для селекта
  def valid_types_of_food
    [
      [(I18n.t 'models.tour_route.types_of_food.personal'), '0'],
      [(I18n.t 'models.tour_route.types_of_food.1_meals'), '1'],
      [(I18n.t 'models.tour_route.types_of_food.2_meals'), '2'],
      [(I18n.t 'models.tour_route.types_of_food.3_meals'), '3'],
      [(I18n.t 'models.tour_route.types_of_food.cafe'), '4'],
      [(I18n.t('models.tour_route.types_of_food.food_other')), '5'],
      [(I18n.t('models.tour_route.types_of_food.food_not')), '6'],
    ]
  end

  def countries
    smart_collect_for_select Country.all.select(:id, :title_ru, :title_en).order(:id)
  end

  def all_tour_types
    smart_collect_for_select TourType.all.select(:id, :title_ru, :title_en).order(:id)
  end

  #
  # @deprecated
  #
  def all_tour_categories
    if tour.tour_type_id
      smart_collect_for_select tour.tour_type.tour_categories.select(:id, :title_ru, :title_en).order(:id)
    else
      []
    end
  end

  #
  # @deprecated
  #
  def deleted_price_items
    tour.tour_price_items.where(deleted: true).order(:id)
  end

  #
  # @deprecated
  #
  def tour_routes_deleted
    tour.tour_routes.where(removed: true).order(:id) if @current_guide && @current_guide.debug_mode
  end

  def options_included_in_price
    TourOption.where(tour_id: tour.id, option_type: :included_in_price, removed: false).order(:id)
  end

  def options_not_included_in_price
    TourOption.where(tour_id: tour.id, option_type: :not_included_in_price, removed: false).order(:id)
  end

  def options_equipment
    TourOption.where(tour_id: tour.id, option_type: :equipment, removed: false).order(:id)
  end

  def options_included_in_price_deleted
    TourOption.where(tour_id: tour.id, option_type: :included_in_price, removed: true) if @current_guide && @current_guide.debug_mode
  end

  def options_not_included_in_price_deleted
    TourOption.where(tour_id: tour.id, option_type: :not_included_in_price, removed: true) if @current_guide && @current_guide.debug_mode
  end

  def options_equipment_deleted
    TourOption.where(tour_id: tour.id, option_type: :equipment, removed: true) if @current_guide && @current_guide.debug_mode
  end

  def all_tour_images
    images = tour.tour_images.order(:removed, :id)
    images = images.where(removed: false) if (@current_guide && !@current_guide.debug_mode)
    images
  end

  #
  # @deprecated
  #
  def options_for_tour_owner
    options = avaible_companies.collect do |permission|
      [permission.guide_company.send('title' + '_' + @current_locale.to_s),
       permission.guide_company.id]
    end
    options.unshift([(I18n.t ("all_pages.labels.you")), '0'])
  end

  #
  # @deprecated
  #
  def options_for_relocation_included
    [
      [(I18n.t "all_pages.labels.yes_label"), true],
      [(I18n.t "all_pages.labels.no_label"), false]
    ]
  end

  private

  # доступные компании для размещения тура
  #
  # @deprecated
  #
  def avaible_companies
    GuideCompanyPermission.where(guide_id: @current_guide.id, full_access: true)
      .or(GuideCompanyPermission.where(guide_id: @current_guide.id,
                                       access_to_tours: true,
                                       full_access: false))
      .includes(:guide_company)
  end
end