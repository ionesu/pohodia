class CitiesController < ApplicationController
  def index
    @cities = if params[:country_id].present?
                Country.find(params[:country_id]).cities.without_region
              elsif params[:region_id].present?
                Region.find(params[:region_id]).cities
              else
                City.all
              end

    respond_to do |format|
      format.json { render json: @cities.order(:id) }
    end
  end
end