module SGuide
  module STour
    class AddTourRoute

      attr_accessor :guide, :tour, :params, :tour_routes_qty, :tour_route

      def initialize(guide, tour, params)
        @guide = guide
        @tour = tour
        @params = params
        @tour_route = TourRoute.new(tour_id: @tour.id)
        @tour_routes_qty = @tour.tour_routes.size
        @response = { object: @tour_route, errors: { tour_route: {} }, result: false }
      end

      def call
        if guide && tour && tour_routes_qty < 20
          if create_tour_route #? tour_route : false
            @response[:object] = tour_route
            @response[:errors] = []
            @response[:result] = true
          else
            @response[:errors][:tour_route].merge!(tour_route.errors.as_json)
          end
        else
          @response[:errors][:tour_route].merge!({ tour_route: ['max count was exceeded'] })
        end
        @response

      end

      private

      def create_tour_route
        tour_route.assign_attributes(params.except(:type_accomodation).except(:type_of_food))
        begin
          set_type_accomodation
        rescue
          return false
        end
        begin
          set_type_of_food
        rescue
          return false
        end
        tour_route.save
      end

      def set_type_accomodation
        TourRoute
        case params[:type_accomodation].to_i
        when 0
          tour_route.accomodation_tent!
        when 1
          tour_route.accomodation_guest_house!
        when 2
          tour_route.accomodation_hut!
        when 3
          tour_route.accomodation_apartment!
        when 4
          tour_route.accomodation_hostel!
        when 5
          tour_route.hotel_1_star!
        when 6
          tour_route.hotel_2_star!
        when 7
          tour_route.hotel_3_star!
        when 8
          tour_route.hotel_4_star!
        when 9
          tour_route.hotel_5_star!
        when 10
          tour_route.accomodation_yacht!
        when 11
          tour_route.accomodation_other!
        when 12
          tour_route.accomodation_not!
        else
          tour_route.accomodation_tent!
        end
        params.delete('type_accomodation')
      end

      def set_type_of_food
        TourRoute
        case params[:type_of_food].to_i
        when 0
          tour_route.food_personal!
        when 1
          tour_route.food_1_meals!
        when 2
          tour_route.food_2_meals!
        when 3
          tour_route.food_3_meals!
        when 4
          tour_route.food_cafe!
        when 5
          tour_route.food_other!
        when 6
          tour_route.food_not!
        else
          tour_route.food_personal!
        end
        params.delete('type_of_food')
      end
    end
  end
end