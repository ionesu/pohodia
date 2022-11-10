module StoryFilterable
  def filter_params
    params
      .require(:story_filter)
      .permit(
        :country_id, :region_id, :city_id, :type_activity_id
      )

  rescue ActionController::ParameterMissing
    {}
  end
end
