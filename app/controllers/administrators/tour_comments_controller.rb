class Administrators::TourCommentsController < AdministratorsController
  before_action :set_tour_comment, only: [:update, :destroy]

  def index
    @tour_comments = TourComment.not_confirmed.includes(:user, :tour)
                       .paginate(page: params[:page], per_page: 10)
  end

  def update
    if @tour_comment.update(tour_comment_params)
      if @tour_comment.reload.confirmed
        ToursMailer.with(tour_comment: @tour_comment).tour_review.deliver_later
      end

      respond_to do |format|
        format.json { render json: @tour_comment }
      end
    end
  end

  def destroy
    @tour_comment.destroy
    redirect_to edit_administrators_tour_path(@tour)
  end

  private

  def set_tour_comment
    @tour = Tour.find(params[:tour_id])
    @tour_comment = @tour.tour_comments.find(params[:id])
  end

  def tour_comment_params
    params.require(:tour_comment).permit(:text, :confirmed)
  end
end