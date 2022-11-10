module SGuide
  module STour
    class UpdateTourOption

      attr_accessor :guide, :tour_option, :option_params

      def initialize(guide, option_id, option_params)
        @guide = guide
        @tour_option = TourOption.find_by(id: option_id)
        @option_params = option_params
        @response = {object: @tour_option, errors: {tour_option: {}}, result: false}  
      end

      def call
        tour_option.assign_attributes(option_params)
        if tour_option.save #? tour_option : false
        	@response[:object] = @tour_option
      		@response[:errors] = []
      		@response[:result] = true
      	else
      		@response[:errors][:tour_option].merge!(@tour_option.errors.as_json)
        end        
        @response
      end
      
    end
  end
end