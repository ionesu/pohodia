module SGuide
  module STour
    class UpdateTourRoute

      attr_accessor :guide, :params, :tour_route

      def initialize(guide, params)
        @guide = guide
        @params = params
        @tour_route = TourRoute.find_by(id: @params[:id])
        @response = {object: @tour_route, errors: {tour_route: {}}, result: false}  
      end

      def call                        
        if update_tour_route #? tour_route : false
        	@response[:object] = @tour_route
      		@response[:errors] = []
      		@response[:result] = true
      	else
      		@response[:errors][:tour_route].merge!(@tour_route.errors.as_json)
        end        
        @response
        
      end

      private

      def update_tour_route
        unless tour_route.update_attributes(params.except(:type_accomodation).except(:type_of_food))
        	return false
        end
        set_type_accomodation
        set_type_of_food
        tour_route.save
      end

      def set_type_accomodation
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
        self.params.delete('type_accomodation')
      end

      def set_type_of_food
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
        self.params.delete('type_of_food')
      end
    end
  end
end