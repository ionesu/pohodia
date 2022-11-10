module CollectionSelection
  def languages_for_select
    smart_collect_for_select(Language.all.order(:id))
  end

  def countries_for_select
    smart_collect_for_select(Country.all.order(:id))
  end

  def regions_for_select
    return [] unless base_object.region
    smart_collect_for_select([base_object.region])
  end

  def cities_for_select
    return [] unless base_object.city
    smart_collect_for_select([base_object.city])
  end
end