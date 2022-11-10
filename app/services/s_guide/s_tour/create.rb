module SGuide
  module STour
    class Create

      attr_accessor :guide, :tour, :tour_params, :city, :tour_category

      def initialize(guide, tour_params)
        @guide = guide
        @tour = guide.tours.new
        @response = { object: @tour, errors: { tour: {} }, result: false }

        @city = City.find_by(id: tour_params[:city_id])
        @tour_category = TourCategory.find_by(id: tour_params[:tour_category_id].to_i)
        @response[:errors][:tour].merge!({ tour_category_id: ['no tour category'] }) unless @tour_category
        @tour_params = tour_params.merge({ tour_type_id: @tour_category.tour_type_id }) if @tour_category
      end

      def call
        if tour_category
          create_tour
        end
        @response
      end

      private

      def create_tour
        add_region_and_country
        if @tour.update_attributes(tour_params)
          Rails.logger.fatal @tour.errors.inspect
          @response[:object] = @tour
          @response[:errors] = []
          @response[:result] = true

          ToursMailer.with(tour: @tour).tour_created.deliver_later
        else
          Rails.logger.fatal @tour.errors.inspect
          @response[:errors][:tour].merge!(@tour.errors.as_json)
        end
        # @tour.guide_id = @guide.id
      end

      def add_region_and_country
        tour.region_id = tour_params[:region_id] if tour_params[:region_id]
        tour.country_id = tour_params[:country_id] if tour_params[:country_id]
      end
    end
  end
end