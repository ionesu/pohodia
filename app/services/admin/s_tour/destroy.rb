module Admin
  module STour
    class Destroy
      def initialize(administrator, tour_id)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
      end

      def call
        if !@tour.deleted? && @administrator && valid_params?
          delete_tour ? true : false
        else
          false
        end
      end

      private

      def delete_tour
        @tour.deleted_at = DateTime.now
        @tour.deleted!
      end
      
      def administrator_has_permissions?
        if @administrator.role_permissions['tours'] || @administrator.full_access
          true
        else
          false
        end
      end

      def valid_params?
        @tour
      end
    end
  end
end