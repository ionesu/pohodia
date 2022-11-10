class Administrators::TourCommentPhotosController < AdministratorsController
  def destroy
    @tour = Tour.find(params[:tour_id])
    @tour_comment_photo = TourCommentPhoto.find(params[:id])
    @tour_comment_photo.destroy

    respond_to do |format|
      format.html { redirect_to edit_administrators_tour_path(@tour) }
      format.json { head :no_content }
    end
  end
end
