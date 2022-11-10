class Guides::TourRoutePointsController < GuidesController
  before_action :set_tour_route, only: [:create, :destroy]
  
  def create
    @tour_route = @tour_route.tour_route_points.build(tour_route_params)

    if @tour_route.save
      respond_to do |format|
        format.json { render json: @tour_route, status: :created }
      end
    else
      respond_to do |format|
        format.json { head :unprocessable_entity }
      end
    end
  end

  def destroy
    if params[:id].present?
      @tour_route_point = @tour_route.tour_route_points.find(params[:id])
    
      if @tour_route_point.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.json { head :unprocessable_entity }
        end
      end
    else
      @tour_route.tour_route_points.destroy_all

      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

  private

  def set_tour_route
    @tour_route = TourRoute.find(params[:tour_route_id])
  end

  def tour_route_params
    params
      .require(:tour_route_point)
      .permit(:geo_latitude, :geo_longitude)
  end
end
