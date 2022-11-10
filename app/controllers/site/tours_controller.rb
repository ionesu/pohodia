# frozen_string_literal: true

class Site::ToursController < SiteController
  include Guastable

  before_action :set_page, only: [:index, :search]
  before_action :set_person, only: [:index, :show]

  def index
    @tour_filter = Tour::Filter.new(filter_params)
    @tours =
      ToursFinder
        .new(
          Tour.includes(:users_tours, :tour_price_items, :tour_routes, :tour_options, :tour_images, :tour_comments)
            .publishable
            .where(id: Tour.can_booking), @tour_filter.to_h
        )
        .call
        .paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html do
        @tours
      end
      format.json do
        render json: @tours, status: :ok
      end
    end
  end

  def search
    @tour_filter = Tour::Filter.new(filter_params)
    @tours = ToursFinder.new(Tour, @tour_filter.to_h).call

    @tours = Tour.publishable.search_by_autocomplete(params[:term]).paginate(page: params[:page], per_page: 200)
    render action: :index
  end

  def show
    @tour_filter = Tour::Filter.new
    @tour = Tour.with_associations.find(params[:id])

    unless current_administrator.present? || @tour.confirmed?
      raise ActiveRecord::RecordNotFound unless @tour.guide == current_guide
    end

    respond_to do |format|
      format.html do
        @tour = Site::PublicTourFacade.new(@tour, nil, @current_locale)
      end
      format.json do
        render json: @tour, status: :ok
      end
    end
  end

  def favorite
    tour = Tour.find(params[:id])
    users_tour = tour.users_tours.find_by(user: user_or_guest)

    users_tour.present? ? users_tour.destroy : user_or_guest.tours << tour

    redirect_to tour_path(tour)
  end

  private

  def filter_params
    params
      .require(:tour_filter)
      .permit(
        :period, :price_start, :price_finish, :duration_from, :duration_to,
        :country_id, :region_id, :city_id, :tour_category_id, :minimum_age, :plane,
        complexities: []
      )
  rescue ActionController::ParameterMissing
    params
      .permit(
        :period, :price_start, :price_finish, :duration_from, :duration_to,
        :country_id, :region_id, :city_id, :tour_category_id, :minimum_age, :plane,
        complexities: []
      )
  end

  def set_page
    @page = Page.find_by(descriptor: 'tours') || Page.find_by(descriptor: 'blog')
  end

  def set_person
    @person = user_or_guest
  end
end
