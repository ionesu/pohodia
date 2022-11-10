module SGuide
  module STour
    class DeleteTourRoute

      attr_accessor :guide, :tour_route

      def initialize(guide, tour_route_id)
        @guide = guide
        @tour_route = TourRoute.find_by(id: tour_route_id)
        @response = {object: @tour_route, errors: {tour_route: {}}, result: false}  
      end

      def call
        #tour_route.removed = true
        #tour_route.save
        
        if @tour_route.update_attributes(removed: true)
        	@response[:object] = @tour_route
      		@response[:errors] = []
      		@response[:result] = true
      	else
      		@response[:errors][:tour_route].merge!(@tour_route.errors.as_json)
        end        
        @response         
      end
    end
  end
end