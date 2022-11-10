class AccessDenied < StandardError
  attr_reader :user

  def initialize(user = nil)
    @user = user
  end
end