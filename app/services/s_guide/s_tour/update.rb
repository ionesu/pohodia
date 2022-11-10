module SGuide
  module STour
    class Update < GuideService

      attr_accessor :guide, :tour, :tour_params, :tour_category

      def initialize(guide, tour_id, tour_params)
        @guide = guide
        @tour = Tour.find_by(id: tour_id)
        @response = {object: @tour, errors: {tour: {}}, result: false}
        @tour_params = tour_params

        if tour_params[:tour_category_id].present?
          tour_category = TourCategory.find_by(id: tour_params[:tour_category_id])
          if tour_category.present?
            @tour_params.merge(tour_type_id: tour_category.tour_type_id)
          end
        end
      end

      def call
        # if tour_category
          update_tour #? tour : false
        # end
        @response
      end

      private

      def update_tour
        #tour.tour_type_id = @tour_category.tour_type_id
        @tour.assign_attributes(tour_params)
        change_guide_owner
        if @tour.save
        	@response[:object] = @tour
        	@response[:errors] = []
        	@response[:result] = true
        else
        	@response[:errors][:tour].merge!(@tour.errors.as_json)
        end
      end

      def change_guide_owner
        if tour.guide_company_id == 0
          tour.guide_id = guide.id
        else
          tour.guide_id = nil
        end
      end
    end
  end
end
