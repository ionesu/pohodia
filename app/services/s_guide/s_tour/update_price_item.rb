module SGuide
  module STour
    class UpdatePriceItem

      attr_accessor :guide, :params, :tour_price_item

      def initialize(guide,  params)
        @guide = guide
        @params = params
        @tour_price_item = TourPriceItem.find_by(id: params[:id])
      end

      def call
        update_tour_price_item ? tour_price_item : false
      end

      private

      def update_tour_price_item
        tour_price_item.assign_attributes(params)
        tour_price_item.save
      end
    end
  end
end