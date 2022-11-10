class Tour::Translate
  class Scope
    extend Dry::Initializer

    option :translator
    option :tours
  end

  include Dry::Transaction

  try :translate, catch: StandardError

  #
  # @param [Tour::Translate::Scope] scope
  # @option scope [Yandex::Translate] :translator
  # @option scope [Array<Tour>] :tours
  #
  # @example
  #   Tour::Translate.new.call(
  #     Tour::Translate::Scope.new(
  #       translator: Yandex::Translate.new,
  #       tours: Tour.all
  #     )
  #   )
  #
  def translate(scope)
    translator = scope.translator

    scope.tours.where(title_en: nil).to_a.each do |tour|
      begin
        tour.title_en = translator.translate(tour.title_ru).last
        tour.description_en = translator.translate(tour.description_ru).last

        tour.tour_routes.each do |tour_route|
          tour_route.title_en = translator.translate(tour_route.title_ru).last
          tour_route.description_en = translator.translate(tour_route.description_ru).last
          tour_route.save!(validate: false)
        end

        tour.tour_options.each do |tour_option|
          tour_option.title_en = translator.translate(tour_option.title_ru).last
          tour_option.save!(validate: false)
        end

        tour.save!(validate: false)
      rescue StandardError => e
        Rails.logger.error(e)
      end
    end
  end
end
