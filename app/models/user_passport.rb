class UserPassport
  attr_reader :object, :current_person, :current_locale

  def initialize(object, current_person, current_locale)
    @object = object
    @current_person = current_person
    @current_locale = current_locale
  end

  def name
    if current_locale.eql?(:ru)
      "#{object.name_ru} #{object.surname_ru}"
    else
      "#{object.name_en} #{object.surname_en}"
    end
  end

  def description
    if current_locale.eql?(:ru)
      object.description_ru
    else
      object.description_en
    end
  end

  def tour_present?
    false
  end

  def avatar
    object.avatar
  end

  def tours
    []
  end

  def stories
    object.stories.to_a.map do |story|
      GuidePassport::StoryCard.new(story, current_person, current_locale)
    end
  end
end
