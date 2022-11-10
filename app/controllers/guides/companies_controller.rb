class Guides::CompaniesController < GuidesController
  def index
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).index?
    @permissions = GuideService.new(current_guide).avaible_companies
    @my_companies_qty = @permissions.where(full_access: true).size
  end

  def tours
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).tours?
    @company = GuideCompany.find(params[:id])
    @tours = Tour.where(guide_company_id: @company.id, global_status: 0)
               .includes(:country, :city, :region, :tour_type, :tour_category)
               .select(
                 :id, :title_ru,
                 :title_en,
                 :country_id,
                 :city_id,
                 :region_id,
                 :tour_type_id,
                 :tour_category_id,
                 :created_at,
                 :updated_at
               )
  end

  def new
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).new?
    @new_company = GuideCompany.new
    @countries = smart_collect_for_select(Country.all.select(:id, :title_ru, :title_en).order(:id))
  end

  def create
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, nil).create?
    result = SGuide::SCompany::Create.new(current_guide, company_create_params).call

    if result
      redirect_to edit_guides_company_path(result)
    else
      redirect_back(fallback_location: guide_root_path)
    end
  end

  def edit
    @company = GuideCompany.includes(:country, :region, :city).find_by(id: params[:id])
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, @company.id).edit?
    @company = SGuide::CompanyFacade.new(@company, current_guide)
  end

  def update
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).update?
    SGuide::SCompany::Update.new(current_guide, params[:id], company_update_params).call
    redirect_back(fallback_location: guide_root_path)
  end

  def add_guide
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).add_guide?
    SGuide::SCompany::AddGuide.new(current_guide, params[:id], params[:guide_company_permission][:email]).call
    redirect_back(fallback_location: guide_root_path)
  end

  def update_guide
    prm = params.require(:guide_company_permission).permit(:access_to_tours, :access_to_company_info, :id)
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).update_guide?
    SGuide::SCompany::UpdateGuide.new(current_guide, params[:guide_company_permission][:id], prm).call
    redirect_back(fallback_location: guide_root_path)
  end

  def delete_guide
    pundit_wrapper SGuide::CompanyPolicy.new(pundit_user, params[:id]).delete_guide?
    SGuide::SCompany::DeleteGuide.new(current_guide, params[:permission_id]).call
    redirect_back(fallback_location: guide_root_path)
  end

  private

  def company_create_params
    params.require(:guide_company).permit(:title_ru, :title_en, :city_id)
  end

  def company_update_params
    params
      .require(:guide_company)
      .permit(
        :title_ru, :title_en, :description_ru, :description_en, :address_ru,
        :address_en, :main_phone, :additional_phone, :email, :site, :logo
      )
  end
end
