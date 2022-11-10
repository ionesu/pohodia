class Site::Stories::ActivitiesController < SiteController
  include StoryFilterable
  include Storiable

  before_action :set_activity, only: :show

  def show
    @story_filter = Story::Filter.new(filter_params.merge(type_activity_id: @activity))
    @stories =
      StoriesFinder
        .new(
          Story.all, @story_filter.to_h
        )
        .call
        .paginate(page: params[:page], per_page: 200)

    render template: 'site/stories/index'
  end

  private

  def set_activity
    @activity = params[:id]
    @activity_selected = true
  end
end
