class Users::ResetPasswordsController < UsersController
  def edit
    @current_user = SUser::UserFacade.new(current_user, @current_locale)
  end

  def update
    result = current_user.update(params_permit)

    respond_to do |format|
      format.html do
        if result
          bypass_sign_in(current_user)
          redirect_back(fallback_location: '/')
        else
          redirect_to user_root_path
        end
      end
      format.js {}
      format.json do
        if result
          render json: { data: {}, status: :ok }
        else
          render json: { data: {}, errors: {}, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def params_permit
    params.require(:user).permit(:password, :password_confirmation)
  end
end