class Site::TourCommentsController < SiteController
  def create
    @tour = Tour.find(params[:tour_id])
    @tour_comment = TourComment.create(tour_comment_params.merge(user: current_user, tour: @tour))

    if tour_comment_photos.present?
      tour_comment_photos[:photo].each do |photo|
        @tour_comment.tour_comment_photos.create(photo: photo)
      end
    end

    respond_to do |format|
      format.html { redirect_to @tour }
    end
  end

  private

  def tour_comment_photos
    tour_comment_photos_params[:tour_comment_photos]
  end

  def tour_comment_params
    params.require(:tour_comment).permit(:text)
  end

  def tour_comment_photos_params
    params.require(:tour_comment).permit(tour_comment_photos: [photo: []])
  end
end