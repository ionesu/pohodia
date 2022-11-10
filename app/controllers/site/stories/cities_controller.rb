class Site::Stories::CitiesController < SiteController
  include StoryFilterable
  include Storiable

  before_action :set_sity, only: :show

  def show
    @story_filter = Story::Filter.new(filter_params.merge(city_id: @city.id, region_id: @city.region_id, country_id: @city.country_id))
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

  def set_sity
    @city = City.find(params[:id])
    @region = @city.region
    @country = @city.country

    @country_selected = true
    @city_selected = true
    @region_selected = true
  end
end
