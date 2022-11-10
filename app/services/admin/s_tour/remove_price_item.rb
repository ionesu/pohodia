module Admin
  module STour
    class RemovePriceItem
      def initialize(administrator, tour_price_item_id)
        @administrator = administrator
        @tour_price_item = TourPriceItem.find_by(id: tour_price_item_id)
      end

      def main
        if @administrator and administrator_has_permissions?
          @tour_price_item.destroy
          @tour_price_item
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
    end
  end
end