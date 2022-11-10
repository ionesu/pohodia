module Admin
  module STour
    class RemoveTourRoute
      def initialize(administrator, tour_route_id)
        @administrator = administrator
        @tour_route = TourRoute.find_by(id: tour_route_id)
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_route
          @tour_route.removed = true
          @tour_route.save
          true
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
    end
  end
end