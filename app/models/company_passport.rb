class CompanyPassport
  attr_accessor :object, :current_person, :current_locale

  def initialize(object, current_person, current_locale)
    @object = object
    @current_person = current_person
    @current_locale = current_locale
  end

  def name
    if current_locale.eql?(:ru)
      object.title_ru
    else
      object.title_en
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
    true
  end

  def address
    if current_locale.eql?(:ru)
      object.address_ru
    else
      object.address_en
    end
  end

  def avatar
    object.logo
  end

  def tours
    object.tours.publishable.includes(:country, :tour_category, :tour_comments, :tour_routes).to_a.map do |tour|
      GuidePassport::TourCard.new(tour, current_person, current_locale)
    end
  end

  def stories
    []
  end
end
