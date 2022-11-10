module Admin
  module SCountry
    class Update
      def initialize(administrator, country_id, country_params)
        @administrator = administrator
        @country = Country.find_by(id: country_id)
        @country_params = country_params
      end

      def main
        if @administrator and administrator_has_permissions?
          update_country ? @country : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['cities'] or @administrator.full_access
          true
        else
          false
        end
      end

      def update_country
        @country.update_attributes(@country_params)
        @country.save
      end
    end
  end
end