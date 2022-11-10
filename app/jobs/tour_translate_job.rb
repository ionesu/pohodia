class TourTranslateJob < ApplicationJob
  queue_as :default

  def perform(guide_id)
    guide = Guide.find(guide_id)

    Tour::Translate.new.call(
      Tour::Translate::Scope.new(
        translator: Yandex::Translate.new,
        tours: guide.tours.includes(:tour_routes, :tour_options)
      )
    )
  end
end
