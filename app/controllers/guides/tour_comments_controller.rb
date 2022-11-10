class Guides::TourCommentsController < GuidesController
  def index
    @tour_comments =
      current_guide.avalible_tour_comments
        .includes(:user, :tour)
        .paginate(page: params[:page], per_page: 10)
  end
end