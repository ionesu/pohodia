class Site::TourRoutesController < SiteController
  before_action :set_tour, only: :index

  def index
    tour_routes = 
      @tour.tour_routes.includes(:tour_route_points)
        .where(removed: false).order(:created_at).map { |a| a.presense }

    respond_to do |format|
      format.json { render json: tour_routes, status: :ok }
    end
  end

  private

  def set_tour
    @tour = Tour.find(params[:tour_id])
  end
end