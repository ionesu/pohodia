module Admin
  module STour
    class Create
      def initialize(administrator, tour_params)
        @administrator = administrator
        @tour = Tour.new()
        @tour_params = tour_params
        @city = City.find_by(id: tour_params[:city_id])
        @tour_category = TourCategory.find_by(id: @tour_params[:tour_category_id].to_i)
      end

      def main
        if @administrator and administrator_has_permissions? and @city and valid_complexity? and @tour_category
          # puts "main -> true"
          update_tour ? @tour : false
        else
          # puts "main -> false"
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

      def valid_complexity?
        (1..5) === @tour_params[:complexity].to_i
      end

      def add_region_and_country
        @region = @city.region
        @country = @region.country if @region
        @country = @city.country unless @region
        @tour.region_id = @region.id if @region
        @tour.country_id = @country.id if @country
      end

      def update_tour
        @tour.tour_type_id = @tour_category.tour_type_id
        @tour.update_attributes(@tour_params)
        @tour.administrator_id = @administrator.id
        add_region_and_country
        @tour.save
        # if  @tour.save
        #   puts "tour saved"
        #   @tour
        # else
        #   puts "tour not saved"
        #   false
        # end
      end
    end
  end
end