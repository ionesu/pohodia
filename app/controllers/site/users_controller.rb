class Site::UsersController < SiteController
  include Guastable

  def show
    @user = User.where.not(confirmed_at: nil).find(params[:id])
    @passport = UserPassport.new(@user, user_or_guest, @current_locale)
  end
end
