class Guides::ProfileController < GuidesController

  before_action :check_permissions

  def edit_profile
    @current_guide = SGuide::GuideFacade.new(current_guide, @current_locale)
    render 'guides/profile/edit_profile'
  end

  def update_profile
    response = SGuide::Profile::UpdateProfile.new(current_guide, guide_params.merge(location_params)).call

    respond_to do |format|
      format.html { redirect_back(fallback_location: guide_root_path) }
      format.js {}
      format.json do
        if response[:result] == true
          render json: { refresh: refresh_profile_guides_path(response[:object], format: :js), data: response[:object] }, status: :ok
        else
          render json: { data: response[:object], errors: response[:errors] }, status: :unprocessable_entity
        end
      end
    end
  end

  def refresh
    @current_guide = SGuide::GuideFacade.new(current_guide, @current_locale)
    respond_to { |format| format.js {} }
  end

  def add_additional_language
    guide = SGuide::Profile::AddAdditionalLanguage.new(current_guide, params[:guide][:main_language_id]).call

    respond_to do |format|
      format.html { redirect_back(fallback_location: guide_root_path) }
      format.js {}
      format.json do
        if guide.present?
          if guide.valid?
            render json: { data: guide, status: :ok }
          elsif guide.errors.present?
            render json: { data: guide, errors: guide.errors, status: :unprocessable_entity }
          else
            render json: { data: guide, errors: {}, status: :unprocessable_entity }
          end
        else
          render json: { data: guide, errors: {}, status: :unknown }
        end
      end
    end
  end

  def delete_additional_language
    guide = SGuide::Profile::DeleteAdditionalLanguage.new(current_guide, params[:id]).call

    respond_to do |format|
      format.html { redirect_back(fallback_location: guide_root_path) }
      format.js {}
      format.json do
        if guide.present?
          if guide.valid?
            render json: { data: guide, status: :ok }
          elsif guide.errors.present?
            render json: { data: guide, errors: guide.errors, status: :unprocessable_entity }
          else
            render json: { data: guide, errors: {}, status: :unprocessable_entity }
          end
        else
          render json: { data: guide, errors: {}, status: :unknown }
        end
      end
    end
  end

  private

  def guide_params
    params
      .require(:guide)
      .permit(
        :name_ru, :name_en, :surname_ru, :surname_en, :description_ru, :description_en,
        :main_phone, :additional_phone, :contact_email, :vk_link, :instagram_link,
        :facebook_link, :country_id, :region_id, :city_id, :main_language_id, :avatar
      )
  end

  def location_params
    params.require(:tour).permit(:region_id, :city_id)

  rescue ActionController::ParameterMissing
    {}
  end

  def check_permissions
    SGuide::ProfilePolicy.new(pundit_user).access_to_profile?
  end
end