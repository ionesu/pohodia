module Admin
  module STour
    class AddNotIncludedInPriceOption
      def initialize(administrator, tour_id,  option)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @option = option
      end

      def main
        if @administrator and administrator_has_permissions? and valid_params?
          add_option_to_list ? @tour : false
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

      def valid_params?
        @tour and @tour.options_not_included_in_price.size < 21 and @tour.options_not_included_in_price.include?(@option) == false and @option.size > 3 and @option.size < 11
      end

      def add_option_to_list
        @tour.options_not_included_in_price << @option
        @tour.save
      end
    end
  end
end