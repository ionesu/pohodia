class SUser::UserFacade < BaseFacade
  include CollectionSelection

  attr_reader :current_user

  #
  # @param [User] current_user
  # @param [Symbol] current_locale
  #
  def initialize(current_user, current_locale = :ru)
    @current_user = current_user
    @current_locale = current_locale
  end

  def base_object
    current_user
  end
end