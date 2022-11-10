class Site::PublicHomeFacade < BaseFacade

  attr_accessor :page, :current_locale

  def initialize(page, current_locale)
    @page = page
    @current_locale = current_locale
  end

  def base_object
    page
  end

  def posts
    #Post.all.limit(4).order("RANDOM()")
    Post.order('created_at desc').limit(4)
  end

  #
  # Вынести в отдельный scope
  #
  def tours
    Tour
      .includes(:tour_price_items, :tour_category, :tour_routes, :users_tours)
      .publishable
      .where(id: Tour.can_booking)
      .where.not(avatar: nil)
      .order(updated_at: :desc)
      .limit(5)
  end

  def countries
    Country.where(id: [212, 18, 1, 71, 7, 217]).order("RANDOM()").limit(6)
  end

  def countries_layout
    [
      { colspan: 10, rowspan: 10, style: "position: absolute; top: 0px; left: 0px; width: 580px; height: 580px;" },
      { colspan: 10, rowspan: 4, style: "position: absolute; top: 0px; left: 580px; width: 580px; height: 232px;" },
      { colspan: 5, rowspan: 6, style: "position: absolute; top: 232px; left: 580px; width: 290px; height: 348px;" },
      { colspan: 5, rowspan: 6, style: "position: absolute; top: 232px; left: 870px; width: 290px; height: 348px;" }
    ]
  end

  def country_turk
    Country.find_by(title_ru: 'Турция')
  end

  def country_hor
    Country.find_by(title_ru: 'Хорватия')
  end

  def country_usa
    Country.find_by(title_ru: 'США')
  end

  def country_arm
    Country.find_by(title_ru: 'Армения')
  end

  def all_countries
    smart_collect_for_select(Country.all)
  end

  def all_cities
    []
  end

  private


end