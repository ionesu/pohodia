module Admin
  module STour
    class UpdatePriceItem
      def initialize(administrator,  params)
        @administrator = administrator
        @params = params
        @tour_price_item = TourPriceItem.find_by(id: params[:id])
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_price_item
          update_tour_price_item ? @tour_price_item : false
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

      def update_tour_price_item
        @tour_price_item.update_attributes(@params)
        @tour_price_item.save
      end
    end
  end
end