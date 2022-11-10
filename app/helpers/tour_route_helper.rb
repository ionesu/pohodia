module TourRouteHelper
  # получение текстового значения типа проживания
  def get_title_type_accomodation(route, locale = :ru)
    if route.accomodation_tent?
      locale == :ru ? 'Палатка' : 'Tent'
    elsif route.accomodation_hut?
      locale == :ru ? 'Хижина' : 'Hut'
    elsif route.accomodation_apartment?
      locale == :ru ? 'Гостевой дом' : 'Apartment'
    elsif route.accomodation_hostel?
      locale == :ru ? 'Хостел' : 'Hostel'
    elsif route.hotel_1_star?
      locale == :ru ? 'Отель 1*' : 'Hotel 1*'
    elsif route.hotel_2_star?
      locale == :ru ? 'Отель 2*' : 'Hotel 2*'
    elsif route.hotel_3_star?
      locale == :ru ? 'Отель 3*' : 'Hotel 3*'
    elsif route.hotel_4_star?
      locale == :ru ? 'Отель 4*' : 'Hotel 4*'
    elsif route.hotel_5_star?
      locale == :ru ? 'Отель 5*' : 'Hotel 5*'
    else
      locale == :ru ? 'Ошибка' : 'Error'
    end
  end

  # получение текстового значения типа питания
  def get_title_type_of_food(route, locale = :ru)
    if route.food_personal?
      locale == :ru ? 'Личное' : 'Personal'
    elsif route.food_1_meals?
      locale == :ru ? '1 разовое' : '1 time'
    elsif route.food_2_meals?
      locale == :ru ? '2 разовое' : '2 time'
    elsif route.food_3_meals?
      locale == :ru ? '3 разовое' : '3 time'
    elsif route.food_cafe?
      locale == :ru ? 'Кафе' : 'Cafe'
    else
      locale == :ru ? 'Ошибка' : 'Error'
    end
  end
end