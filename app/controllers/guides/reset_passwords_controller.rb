class Guides::ResetPasswordsController < GuidesController
  def edit
    @current_guide = current_guide
  end
  
  def update
    result = current_guide.update(params_permit)

    respond_to do |format|
      format.html do
        if result
          bypass_sign_in(current_guide)
          redirect_to guide_root_path
        else
          redirect_to guide_root_path
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
    params.require(:guide).permit(:password, :password_confirmation)
  end
end