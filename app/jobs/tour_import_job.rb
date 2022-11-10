class TourImportJob < ApplicationJob
  queue_as :default

  def perform(current_guide_id, import_request_id)
    current_guide = Guide.find(current_guide_id)
    import_request = ImportRequest.find(import_request_id)
    Tour::Importer.new.call(Tour::Importer::Scope.new(guide: current_guide, content: import_request.content))
  end
end
