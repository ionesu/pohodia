class SGuide::CompanyFacade

  attr_reader :company, :current_guide

  def initialize(company, current_guide = nil)
    @company = company
    @current_guide = current_guide
  end

  def base_object
    @company
  end

  def current_guide_has_full_access?
    company_guide_permissions.where(guide_id: current_guide.id, full_access: true).size > 0
  end

  def company_guide_permissions
    GuideCompanyPermission.where(guide_company_id: company.id).order(:id)
  end

  def new_guide_company_permission
    GuideCompanyPermission.new
  end
end