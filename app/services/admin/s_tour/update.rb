module Admin
  module STour
    class Update
      def initialize(administrator, tour_id, tour_params)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @tour_params = tour_params
        @tour_category = TourCategory.find_by(id: @tour_params[:tour_category_id].to_i)
      end

      def main
        if @administrator and administrator_has_permissions? and valid_complexity? and @tour_category
          puts "true"
          update_tour ? @tour : false
        else
          puts "false"
          false
        end
      end

      private

      def administrator_has_permissions?
        @administrator.role_permissions['tours'] or @administrator.full_access
      end

      def valid_complexity?
        (1..5) === @tour_params[:complexity].to_i
      end

      # def set_tour_category
      #   tour_category = TourCategory.find_by(id: @tour_params[:tour_category_id].to_i)
      #   raise('invalid tour category') unless tour_category
      #   tour_type = tour_category.tour_type
      #   raise('invalid tour_type') unless tour_type
      #   @tour.tour_type_id = tour_type.id
      #   @tour.tour_category_id = tour_category.id
      #   @tour_params.delete(:tour_category_id)
      #   @tour_params.delete(:tour_type_id)
      # end

      def update_tour
        @tour.tour_type_id = @tour_category.tour_type_id
        @tour.update_attributes(@tour_params)
        @tour.save
      end
    end
  end
end