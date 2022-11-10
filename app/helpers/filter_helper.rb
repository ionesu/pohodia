module FilterHelper

  module_function

  def complexity_with_labels
    [[(I18n.t 'models.tour_route.complexity.very_easy'), '1'],
     [(I18n.t 'models.tour_route.complexity.easy'), '2'],
     [(I18n.t 'models.tour_route.complexity.middle'), '3'],
     [(I18n.t 'models.tour_route.complexity.hard'), '4'],
     [(I18n.t 'models.tour_route.complexity.very_hard'), '5']]
  end

  def complexities
    [
      [(I18n.t 'models.tour_route.complexity.very_easy'), '1'],
      [(I18n.t 'models.tour_route.complexity.easy'), '2'],
      [(I18n.t 'models.tour_route.complexity.middle'), '3'],
      [(I18n.t 'models.tour_route.complexity.hard'), '4'],
      [(I18n.t 'models.tour_route.complexity.very_hard'), '5']
    ]
  end

  def planes
    [
      [(I18n.t('tour_filter.plane_prices.accept')), '1'],
      [(I18n.t('tour_filter.plane_prices.dismiss')), '2']
    ]
  end

  def type_of_accomodation
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
      [(I18n.t('models.tour_route.types_accomodation.not')), '12']
    ]
  end

  def options_for_relocation_included
    [
      [(I18n.t "all_pages.labels.yes_label"), true],
      [(I18n.t "all_pages.labels.no_label"), false]
    ]
  end

  def countries
    c = Country.cached_all

    # c.map { |v| [v.title_ru, v.id] }
    # c.map { |v| [v.title_en, v.id] }
    #
    # @current_locale.eql?(:ru) ?
    #   Country.order(:id).pluck(:title_ru, :id) :
    #   Country.order(:id).pluck(:title_en, :id)

    @current_locale.eql?(:ru) ?
      c.map { |v| [v.title_ru, v.id] } :
      c.map { |v| [v.title_en, v.id] }
  end

  def regions(country = nil)
    if country.blank?
      []
    else
      @current_locale.eql?(:ru) ?
        Region.where(country: country).pluck(:title_ru, :id) :
        Region.where(country: country).pluck(:title_en, :id)
    end
  end

  def cities(country_region = {})
    if country_region[:region_id].present?
      @current_locale.eql?(:ru) ?
        City.where(region: country_region[:region_id]).pluck(:title_ru, :id) :
        City.where(region: country_region[:region_id]).pluck(:title_en, :id)
    elsif country_region[:country_id].present?
      @current_locale.eql?(:ru) ?
        City.where(country: country_region[:country_id], region_id: nil).pluck(:title_ru, :id) :
        City.where(country: country_region[:country_id], region_id: nil).pluck(:title_en, :id)
    else
      []
    end
  end

  def tour_categories
    TourCategory.pluck(:title_ru, :id)
  end

  def many_days
    [
      ['Многодневный', true],
      ['Однодневный', false]
    ]
  end

  def has_booking_without_date
    [
      ['Да', true],
      ['Нет', false]
    ]
  end

  def tour_data_filters tour
    filters = []
    tour.filters_hash.each do |k, v|
      filters << "data-#{k.to_s.dasherize}=#{v}"
    end
    filters.join(' ')
  end
end
