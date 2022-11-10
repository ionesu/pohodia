class Site::Stories::CountriesController < SiteController
  include StoryFilterable
  include Storiable

  before_action :set_country, only: :show

  def show
    @story_filter = Story::Filter.new(filter_params.merge(country_id: @country.id))
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

  def set_country
    @country = Country.find(params[:id])
    @country_selected = true
  end
end
