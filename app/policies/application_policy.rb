class ApplicationPolicy

  def access_to_component?(user, permission)
    if user && (user.role_permissions[permission] || user.full_access)
      true
    else
      raise "user not has permissions"
    end
  end

  # attr_reader :user, :record
  #
  # def initialize(user, record)
  #   @user = user
  #   @record = record
  # end
  #
  # def index?
  #   false
  # end
  #
  # def show?
  #   false
  # end
  #
  # def create?
  #   false
  # end
  #
  # def new?
  #   create?
  # end
  #
  # def update?
  #   false
  # end
  #
  # def edit?
  #   update?
  # end
  #
  # def destroy?
  #   false
  # end
  #
  # class Scope
  #   attr_reader :user, :scope
  #
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end
  #
  #   def resolve
  #     scope.all
  #   end
  # end
end
