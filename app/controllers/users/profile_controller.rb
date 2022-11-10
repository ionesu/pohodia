# frozen_string_literal: true

class Users::ProfileController < UsersController
  def edit
    @current_user = SUser::UserFacade.new(current_user, @current_locale)
  end

  def update
    if current_user.update(user_params.merge(location_params))
      redirect_to user_root_url
    else
      Rails.logger.error(current_user.errors.to_json)
      redirect_to edit_users_profile_url
    end
  end

  def refresh
    @current_user = SUser.userFacade.new(current_user, @current_locale)
    respond_to { |format| format.js {} }
  end

  private

  def user_params
    params.require(:user)
      .permit(
        :name_ru, :name_en, :surname_ru, :surname_en, :avatar, :main_language_id,
        :description_ru, :description_en, :main_phone, :additional_phone, :contact_email,
        :vk_link, :instagram_link, :facebook_link, :country_id, :region_id, :city_id
      )
  end

  def location_params
    params.require(:tour)
      .permit(:region_id, :city_id)
  end
end
