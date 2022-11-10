module SGuide
  class TourPolicy < ApplicationPolicy

    attr_accessor :guide, :tour, :access_to_tours, :company

    def initialize(guide, tour = nil)
      @guide = guide
      @tour = tour
    end

    def access_to_tours?
      access_to_component?(guide, 'tours') ? true : raise(AccessDenied.new)
    end

    def access_to_tour?
      if tour.guide_id
        raise AccessDenied.new unless access_to_tours? && tour.guide_id == guide.id
      elsif tour.guide_company_id
        raise AccessDenied.new unless access_to_tours? && guide_has_access_to_company(tour.guide_company_id)
      end
    end

    private

    def guide_has_access_to_company(company_id)
      company = GuideCompany.find_by(id: company_id)
      company.guide_company_permissions.exists?(guide_id: guide.id) if company
    end
  end
end