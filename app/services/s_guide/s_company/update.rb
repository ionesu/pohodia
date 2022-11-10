module SGuide
  module SCompany
    class Update
      def initialize(guide, company_id, company_params)
        @guide = guide
        @company = GuideCompany.find_by(id: company_id)
        @company_params = company_params
      end

      def call
        @company.update_attributes(@company_params)
      end

      private

      # здесь будут еще методы

    end
  end
end