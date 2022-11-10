class Site::BookingsController < SiteController
  def create
    @booking = Booking.create(booking_params)
    ToursMailer.with(tour: @booking.tour).tour_booking.deliver_later
    redirect_to tour_path(booking_params[:tour_id])

      #respond_to do |format|
      #  format.html do
      #    redirect_to tour_path(tour_params[:tour_id])
      #  end
      #  format.json do
      #    render json: @booking, status: :ok
      #  end
      #end
  end

  private

  def booking_params
    params
      .require(:booking)
      .permit(
        :tour_price_item_id, :user_id, :customer_email, :customer_phone,
        :customer_name, :customer_comment, :terms_agree, :privacy_agree,
        :parties, :booking_status_id, :tour_id
      )
  end

  def tour_params
    params
      .permit(:tour_id)
  end
end