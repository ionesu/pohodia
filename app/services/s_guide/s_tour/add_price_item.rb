module SGuide
  module STour
    class AddPriceItem

      attr_accessor :guide, :tour, :params, :tour_price_item

      def initialize(guide, tour, params)
        @guide = guide
        @tour = tour
        @params = params
        @tour_price_item = @tour.tour_price_items.new
        @response = {object: @tour_price_item, errors: {tour_price_item: {}}, result: false}        
      end

      def call
        if valid_price_items_size?
          if create_tour_price_item #? tour_price_item : false
          	@response[:object] = @tour_price_item
        		@response[:errors] = []
        		@response[:result] = true
        	else
        		@response[:errors][:tour_price_item].merge!(@tour_price_item.errors.as_json)
          end
        else
        	@response[:errors][:tour_price_item].merge!({tour_price_item: ['max count 21 was exceeded']}) 
        end
        @response
      end

      private

      def valid_price_items_size?
        tour.tour_price_items.where(deleted: false).size < 21
      end

      def create_tour_price_item
        tour_price_item.assign_attributes(params)
        tour_price_item.save
      end
    end
  end
end