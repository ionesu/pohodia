module SGuide
  module STour
    class DeleteTourOption

      attr_accessor :guide, :tour_option

      def initialize(guide, option_id)
        @guide = guide
        @tour_option = TourOption.find_by(id: option_id)
        @response = {object: @tour_option, errors: {tour_option: {}}, result: false}  
      end

      def call
        #@tour_option.removed = true
        #@tour_option.save ? @tour_option : false
        
        if @tour_option.update_attributes(removed: true)
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