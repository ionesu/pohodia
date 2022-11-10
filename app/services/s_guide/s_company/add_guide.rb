module SGuide
  module SCompany
    class AddGuide

      attr_accessor :guide, :company, :new_guide

      def initialize(guide, company_id, new_guide_email)
        @guide = guide
        @company = GuideCompany.find_by(id: company_id)
        @new_guide = Guide.find_by(email: new_guide_email)
      end

      def call
        if company && new_guide && !new_guide_already_in_company?
          add_guide_to_company
        end
      end

      private

      def new_guide_already_in_company?
        company.guide_company_permissions.exists?(guide_id: new_guide.id)
      end

      def add_guide_to_company
        company.guide_company_permissions.create(guide_id: new_guide.id, guide_company_id: company.id,
                                                 access_to_tours: true, access_to_company_info: false,
                                                 full_access: false)
      end
    end
  end
end