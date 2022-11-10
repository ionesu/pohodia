module TourFormHelper
  def tour_categories
    @current_locale.eql?(:ru) ?
      TourCategory.pluck(:title_ru, :id) :
      TourCategory.pluck(:title_en, :id)
  end

  #
  # Типы проживания для селекта
  #
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

  #
  # Типы питания для селекта
  #
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
end