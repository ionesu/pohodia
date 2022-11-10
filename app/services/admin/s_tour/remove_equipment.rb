module Admin
  module STour
    class RemoveEquipment
      def initialize(administrator, tour_id,  option)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @option = option
      end

      def main
        if @administrator and administrator_has_permissions? and valid_params?
          remove_option_from_list ? @tour : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['tours'] or @administrator.full_access
          true
        else
          false
        end
      end

      def valid_params?
        @tour and @tour.equipment_list.include?(@option)
      end

      def remove_option_from_list
        @tour.equipment_list.delete @option
        @tour.equipment_list_removed << @option
        @tour.save
      end
    end
  end
end