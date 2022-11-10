module SGuide
  class CompanyPolicy < ApplicationPolicy

    attr_accessor(:guide, :company)

    def initialize(guide, company_id = nil)
      @guide = guide
      @company = GuideCompany.find_by(id: company_id) if company_id
    end

    def index?
      access_to_companies?
    end

    def tours?
      access_to_tours?
    end

    def new?
      access_to_companies?
    end

    def create?
      access_to_companies? && valid_companies_qty?
    end

    def update?
      access_to_company?
    end

    def edit?
      access_to_company?
    end

    def add_guide?
      access_to_company? && guide_has_full_access_in_company?
    end

    def update_guide?
      access_to_company? && guide_has_full_access_in_company?
    end

    def delete_guide?
      access_to_company? && guide_has_full_access_in_company?
    end

    private

    def access_to_tours?
      permission = get_permission_for_current_guide
      access_to_companies? && permission && (permission.access_to_tours || permission.full_access)
    end

    def access_to_companies?
      access_to_component?(guide, 'companies')
    end

    def access_to_company?
      permission = get_permission_for_current_guide
      access_to_companies? && permission && (permission.access_to_company_info || permission.full_access)
    end

    def guide_has_full_access_in_company?
      permission = get_permission_for_current_guide
      permission.full_access
    end

    def valid_companies_qty?
      guide.guide_company_permissions.where(full_access: true).size < 5
    end

    def get_permission_for_current_guide
      company.guide_company_permissions.find_by(guide_id: guide.id)
    end
  end
end