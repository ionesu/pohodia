class SGuide::GuideFacade < BaseFacade
  attr_reader :current_guide

  delegate :avalible_bookings, :to => :current_guide, :allow_nil => true
  delegate :avalible_tours, :to => :current_guide, :allow_nil => true
  delegate :avalible_tour_comments, :to => :current_guide, :allow_nil => true

  def initialize(current_guide, current_locale = :ru)
    @current_guide = current_guide
    @current_locale = current_locale
  end

  def base_object
    current_guide
  end

  def tours
    current_guide.tours
  end

  def tour_comments
    current_guide.tour_comments
  end

  def countries_for_select
    smart_collect_for_select(Country.all.select(:id, :title_ru, :title_en).order(:id))
  end

  def regions_for_select
    if current_guide.region_id
      smart_collect_for_select(Region.where(id: current_guide.region_id).select(:id, :title_ru, :title_en).order(:id))
    else
      []
    end
  end

  def cities_for_select
    if current_guide.city_id
      smart_collect_for_select(City.where(id: current_guide.city_id).select(:id, :title_ru, :title_en).order(:id))
    else
      []
    end
  end

  def languages_for_select
    exec_langs_ids = current_guide.additional_languages_ids
   # exec_langs_ids << current_guide.main_language_id if current_guide.main_language_id
    smart_collect_for_select(Language.all.select(:id, :title_ru, :title_en).order(:id))
  end

  def additional_languages
    Language.where(id: current_guide.additional_languages_ids)
  end

end