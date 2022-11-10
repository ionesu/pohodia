class RegionsController < ApplicationController
  def index
    regions = if params[:country_id].present?
                Country.find(params[:country_id]).regions
              else
                Region.all
              end

    respond_to do |format|
      format.json { render json: regions.order(:id) }
    end
  end
end