module SGuide
  module SCompany
    class UpdateGuide

      attr_accessor :current_guide, :guide_company_permission, :params

      def initialize(current_guide, guide_company_permission_id, params)
        @current_guide = current_guide
        @guide_company_permission = GuideCompanyPermission.find_by(id: guide_company_permission_id)
        @params = params
      end

      def call
        guide_company_permission.assign_attributes(params)
        guide_company_permission.save
      end
    end
  end
end