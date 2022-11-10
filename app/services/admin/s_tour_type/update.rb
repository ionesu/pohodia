module Admin
  module STourType
    class Update
      def initialize(administrator, tour_type_id, tour_type_params)
        @administrator = administrator
        @tour_type = TourType.find_by(id: tour_type_id)
        @tour_type_params = tour_type_params
      end

      def main
        if @administrator and administrator_has_permissions?
          update_tour_type ? @tour_type : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['tour_types'] or @administrator.full_access
          true
        else
          false
        end
      end

      def update_tour_type
        @tour_type.update_attributes(@tour_type_params)
        @tour_type.save
      end
    end
  end
end