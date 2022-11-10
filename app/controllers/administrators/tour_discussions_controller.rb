class Administrators::TourDiscussionsController < AdministratorsController
  def create
    @tour = Tour.find(params[:tour_id])
    @tour_discussion =
      TourDiscussion.new(
        tour_discussion_params.merge(administrator: current_administrator, tour: @tour)
      )
    @tour_discussion.save!
    ToursMailer.with(tour: @tour).tour_moderation.deliver_later

    respond_to do |format|
      format.js { render inline: "location.reload();" }
    end
  end

  #
  # Отправить комментарий на доработку гиду
  #
  def decline
    @tour = Tour.find(params[:tour_id])
    @tour_discussion = @tour.tour_discussions.find(params[:id])
    @tour_discussion.decline

    redirect_to edit_administrators_tour_path(@tour)
  end

  private

  def tour_discussion_params
    params.require(:tour_discussion).permit(:text)
  end
end
