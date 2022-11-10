module SGuide
  module SCompany
    class Create
      attr_accessor :guide, :company_params, :new_company, :city, :region

      def initialize(guide, company_params)
        @guide = guide
        @company_params = company_params
        @new_company = GuideCompany.new
        @city = City.find_by(id: @company_params[:city_id])
        @region = city.region if city.present?
      end

      def call
        company = create_company
        if company
          set_company_admin(company)
          company
        else
          false
        end
      end

      private

      def add_region_and_country
        country = region.country if region
        country = city&.country unless region
        new_company.region_id = region.id if region
        new_company.country_id = country.id if country
      end

      def create_company
        add_region_and_country
        new_company.update_attributes(company_params)
        new_company
      end

      def set_company_admin(company)
        company
          .guide_company_permissions
          .create(
            guide_id: guide.id,
            access_to_tours: true,
            access_to_company_info: true,
            full_access: true
          )
      end
    end
  end
end