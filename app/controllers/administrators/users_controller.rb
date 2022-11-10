class Administrators::UsersController < AdministratorsController
  def index
    @users = User.active.order(:created_at)
  end
end