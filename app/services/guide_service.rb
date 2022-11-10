class GuideService < BaseService
  def initialize(guide)
    @guide = guide
  end

  # получение id компаний у которых гид может создавать туры
  def avaible_companies_ids
    companies.pluck(:guide_company_id)
  end

  # получение компаний гида
  def avaible_companies
    companies.select(:id, :guide_company_id, :full_access, :access_to_tours, :access_to_company_info).includes(:guide_company)
  end

  private

  def companies
    GuideCompanyPermission.where(guide_id: @guide.id, full_access: true).or(GuideCompanyPermission.where(guide_id: @guide.id,
                                                                                                         access_to_tours: true,
                                                                                                         full_access: false))
  end
end