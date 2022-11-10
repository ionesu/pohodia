module TourFilterable
  # def index
  #   @tour_filter = Tour::Filter.new(filter_params)
  #   @tours =
  #     ToursFinder
  #       .new(Tour.includes(:users_tours).publishable, @tour_filter.to_h)
  #       .call
  #       .paginate(page: params[:page], per_page: 200)
  # end

  def filter_params
    params
      .require(:tour_filter)
      .permit(
        :period, :price_start, :price_finish, :duration_from, :duration_to,
        :country_id, :region_id, :city_id, :tour_category_id, :minimum_age,
        complexities: [], planes: []
      )

  rescue ActionController::ParameterMissing
    {}
  end
end