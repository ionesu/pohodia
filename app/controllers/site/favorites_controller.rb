class Site::FavoritesController < SiteController
  include Guastable

  skip_before_action :verify_authenticity_token
  before_action :set_page, only: [:index]

  def index
    @tours = user_or_guest.tours
  end

  def create
    tour = Tour.find(params[:tour_id])
    users_tour = tour.users_tours.find_by(user: user_or_guest)

    users_tour.present? ? users_tour.destroy : user_or_guest.tours << tour

    head :ok
  end

  private

  def set_page
    @page = Page.find_by(descriptor: 'favorites') || Page.find_by(descriptor: 'blog')
  end
end