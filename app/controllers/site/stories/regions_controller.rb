class Site::Stories::RegionsController < SiteController
  include StoryFilterable
  include Storiable

  before_action :set_region, only: :show

  def show
    @story_filter = Story::Filter.new(filter_params.merge(region_id: @region.id, country_id: @region.country_id))
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

  def set_region
    @region = Region.find(params[:id])
    @country = @region.country
    @country_selected = true
    @region_selected = true
  end
end
