module Admin
  module STour
    class AddPriceItem
      def initialize(administrator, tour_id, params)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @params = params
        @tour_price_item = TourPriceItem.new
        @tour_price_items_count = @tour.tour_price_items.size
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_price_items_count < 20
          create_tour_price_item ? @tour_price_item : false
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

      def create_tour_price_item
        @tour_price_item.update_attributes(@params)
        @tour_price_item.tour_id = @tour.id
        @tour_price_item.save
      end
    end
  end
end