class Site::StoriesController < SiteController
  before_action :set_page, only: :index

  def index
    @story_filter = Story::Filter.new(filter_params)
    @stories =
      StoriesFinder
        .new(
          Story.all, @story_filter.to_h
        )
        .call
        .paginate(page: params[:page], per_page: 200)
  end

  def show
    @story = Story.find(params[:id])
  end

  private

  def filter_params
    params
      .require(:story_filter)
      .permit(
        :country_id, :region_id, :city_id, :type_activity_id
      )

  rescue ActionController::ParameterMissing
    {}
  end

  def set_page
    @page = Page.find_by(descriptor: 'stories') || Page.find_by(descriptor: 'blog')
  end
end
