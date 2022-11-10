module SGuide
  module STour
    class DeletePriceItem

      attr_accessor :guide, :tour_price_item

      def initialize(guide, tour_price_item_id)
        @guide = guide
        @tour_price_item = TourPriceItem.find_by(id: tour_price_item_id)
        @response = {object: @tour_price_item, errors: {tour_price_item: {}}, result: false}           
      end

      def call                
        if tour_price_item.update_attributes(deleted: true)
        	@response[:object] = @tour_price_item
      		@response[:errors] = []
      		@response[:result] = true
      	else
      		@response[:errors][:tour_price_item].merge!(tour_price_item.errors.as_json)
        end        
        @response        
      end
    end
  end
end