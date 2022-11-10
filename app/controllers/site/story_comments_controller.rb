class Site::StoryCommentsController < SiteController
  def create
    @story = Story.find(params[:story_id])
    @story_comment = StoryComment.create(story_comment_params.merge(user: current_user, story: @story))

    if story_comment_photos.present?
      story_comment_photos[:photo].each do |photo|
        @story_comment.story_comment_photos.create(photo: photo)
      end
    end

    respond_to do |format|
      format.html { redirect_to @story }
    end
  end

  private

  def story_comment_photos
    story_comment_photos_params[:story_comment_photos]
  end

  def story_comment_params
    params.require(:story_comment).permit(:text)
  end

  def story_comment_photos_params
    params.require(:story_comment).permit(story_comment_photos: [photo: []])
  end
end