module Admin
  module STourCategory
    class Update
      def initialize(administrator, tour_category_id, tour_category_params)
        @administrator = administrator
        @tour_category = TourCategory.find_by(id: tour_category_id)
        @tour_type = TourType.find_by(id: tour_category_params[:tour_type_id])
        @tour_category_params = tour_category_params
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_type
          update_tour_category ? @tour_category : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['tour_categories'] or @administrator.full_access
          true
        else
          false
        end
      end

      def update_tour_category
        @tour_category.update_attributes(@tour_category_params)
        @tour_category.save
      end
    end
  end
end