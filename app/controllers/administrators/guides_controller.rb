class Administrators::GuidesController < AdministratorsController
  def index
    @guides = Guide.all.order(:created_at)
  end
end