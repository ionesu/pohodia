class Guides::TourDiscussionsController < GuidesController
  def update
    @tour = current_guide.avalible_tours.find(params[:tour_id])
    @tour_discussion = @tour.tour_discussions.find(params[:id])
    @tour_discussion.update(tour_discussion_params)

    redirect_to edit_guides_tour_path(@tour)
  end

  private

  def tour_discussion_params
    params.require(:tour_discussion).permit(:confirmed)
  end
end
