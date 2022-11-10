module Admin
  module STour
    class AddTourRoute
      def initialize(administrator, tour_id, params)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @params = params
        @tour_route = TourRoute.new(tour_id: @tour.id)
        @tour_routes_count = @tour.tour_routes.size
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_routes_count < 20
          create_tour_route ? @tour_route : false
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

      def create_tour_route
        set_type_accomodation
        set_type_of_food
        @tour_route.update_attributes(@params)
        @tour_route.save
      end

      def set_type_accomodation
        case @params[:type_accomodation].to_i
        when 0
          @tour_route.accomodation_tent!
        when 1
          @tour_route.accomodation_guest_house!
        when 2
          @tour_route.accomodation_hut!
        when 3
          @tour_route.accomodation_apartment!
        when 4
          @tour_route.accomodation_hostel!
        when 5
          @tour_route.hotel_1_star!
        when 6
          @tour_route.hotel_2_star!
        when 7
          @tour_route.hotel_3_star!
        when 8
          @tour_route.hotel_4_star!
        when 9
          @tour_route.hotel_5_star!
        else
          @tour_route.accomodation_tent!
        end
        @params.delete('type_accomodation')
      end

      def set_type_of_food
        case @params[:type_of_food].to_i
        when 0
          @tour_route.food_personal!
        when 1
          @tour_route.food_1_meals!
        when 2
          @tour_route.food_2_meals!
        when 3
          @tour_route.food_3_meals!
        when 4
          @tour_route.food_cafe!
        else
          @tour_route.food_personal!
        end
        @params.delete('type_of_food')
      end
    end
  end
end