class Site::ApiController < ApplicationController

  def country_regions
    country = Country.find params[:country_id]
    regions = country.regions.select(:id, :title_ru, :title_en).order(:id)
    respond_to do |format|
      format.json { render json: regions }
    end
  end

  def region_cities
    region = Region.find params[:region_id]
    cities = region.cities.select(:id, :title_ru, :title_en).order(:id)
    respond_to do |format|
      format.json { render json: cities }
    end
  end

  # предусмотреть мультиязычность
  # отдавать title_ru или title_en в зависимости от текущей локали
  def tour_type_categories
    tour_type = TourType.find_by(id: params[:tour_type_id])
    categories = tour_type.tour_categories.select(:id, :title_ru, :title_en)
    respond_to do |format|
      format.json { render json: categories }
    end
  end

  def search_brief
    tours = Tour.publishable.search_by_autocomplete(params[:term])
    respond_to do |format|
      format.json {
        render json: {
          total: tours.size,
          tours: tours.take(12).map { |t| { id: t.id, label: t.brief_name, value: t.brief_name, pre: t.address_name } }
        }
      }
    end
  end

end