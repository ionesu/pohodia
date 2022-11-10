class Site::PublicTourFacade < TourFacade

  attr_reader :tour

  def initialize(tour, current_tourist = nil, current_locale = :ru)
    @tour = tour
    @current_tourist = current_tourist
    @current_locale = current_locale
  end

  def route_duration
  	tour.route_duration
    #tour.tour_routes.where(removed: false).size
  end

  def tour_routes
    tour.tour_routes
  end

  def external_url
    tour.external_url
  end

  def show_map?
    tour.show_map?
  end

  def id
    @tour.id
  end

  def all_images
    get_all_tour_images
  end

  def many_days?
    tour.many_days
  end

  def images
    images = get_all_tour_images
    if images.size > 1
      images.drop(1)
    else
      []
    end
  end

  def first_image
    images = get_all_tour_images
    if images.size > 0
      images.first
    end
  end

  def all_price_items
    tour.tour_price_items.where(deleted: false).order(:id)
  end

  private

  def get_tour_price_items
    tour.tour_price_items.where(deleted: false).order(:price)
  end

  def get_all_tour_images
    tour.tour_images.where(removed: false).order(:id)
  end
end
