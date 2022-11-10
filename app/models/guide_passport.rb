class GuidePassport
  attr_reader :object, :guide, :current_person, :current_locale

  def initialize(guide, current_person, current_locale)
    @guide = guide
    @object = guide
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
    true
  end

  def avatar
    object.avatar
  end

  def tours
    object.tours.publishable.includes(:country, :tour_category, :tour_comments, :tour_routes).to_a.map do |tour|
      TourCard.new(tour, current_person, current_locale)
    end
  end

  def stories
    object.stories.to_a.map do |story|
      StoryCard.new(story, current_person, current_locale)
    end
  end

  class TourCard
    attr_accessor :object
    attr_accessor :title
    attr_accessor :description
    attr_accessor :avatar
    attr_accessor :like
    attr_accessor :days_amount
    attr_accessor :reviews_amount
    attr_accessor :current_person
    attr_accessor :current_locale

    def initialize(object, current_person, current_locale)
      @object = object
      @current_person = current_person
      @current_locale = current_locale
    end

    def id
      object.id
    end

    def country_name
      current_locale.eql?(:ru) ? object&.country&.title_ru : object&.country&.title_en
    end

    def category_name
      current_locale.eql?(:ru) ? object.tour_category.title_ru : object.tour_category.title_en
    end

    def title
      current_locale.eql?(:ru) ? object.title_ru : object.title_en
    end

    def description
      current_locale.eql?(:ru) ? object.description_ru : object.description_en
    end

    def avatar
      object.avatar.in_list
    end

    def like
      current_person.users_tours.map(&:tour_id).include?(object.id)
    end

    def days_amount
      object.route_duration
    end

    def reviews_amount
      object.tour_comments.select { |comment| comment.confirmed? }.size
    end
  end

  class StoryCard
    attr_accessor :name
    attr_accessor :description
    attr_accessor :avatar
    attr_accessor :object
    attr_accessor :current_locale

    def initialize(object, current_person, current_locale)
      @object = object
      @current_person = current_person
      @current_locale = current_locale
    end

    def id
      object.id
    end

    def title
      if current_locale.eql?(:ru)
        object.title_ru
      else
        object.title_en
      end
    end

    def description
      if current_locale.eql?(:ru)
        object.text_ru
      else
        object.text_en
      end
    end

    def image
      object.image.in_list.to_s
    end
  end
end
