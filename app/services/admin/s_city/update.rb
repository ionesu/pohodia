module Admin
  module SCity
    class Update
      def initialize(administrator, city_id, city_params)
        @administrator = administrator
        @city = City.find_by(id: city_id)
        @city_params = city_params
      end

      def main
        if @administrator and administrator_has_permissions?
          update_city ? @city : false
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

      def update_city
        @city.update_attributes(@city_params)
        @city.save
      end
    end
  end
end