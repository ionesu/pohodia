class Guides::BookingsController < GuidesController
  def index
    @bookings =
      current_guide.avalible_bookings
        .paginate(page: params[:page], per_page: 10)
  end
end