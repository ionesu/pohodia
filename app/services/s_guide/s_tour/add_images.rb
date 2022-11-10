module SGuide
  module STour
    class AddImages
      attr_accessor :guide, :tour, :params_images, :tour_images_qty

      MAX_COUNT_IMAGES = 9

      def initialize(guide, tour, images)
        @guide = guide
        @tour = tour
        @params_images = images
        @tour_images_qty = @tour.tour_images.where(removed: false).count
        @response = {object: @tour, errors: {tour: {}}, result: false}    
      end

      def call
        if tour_images_qty < MAX_COUNT_IMAGES && params_images.size > 0
          if create_tour_images #? tour : false
          	@response[:object] = @tour
        		@response[:errors] = []
        		@response[:result] = true
        	else
        		@response[:errors][:tour].merge!(@tour.errors.as_json)
          end
        else
        	@response[:errors][:tour].merge!({tour: ['max count 9 was exceeded']})
        end
        @response        
      end

      private

      def create_tour_images
        params_images.each do |image|
          if tour_images_qty < MAX_COUNT_IMAGES
            new_image = TourImage.new(tour_id: tour.id, guide_id: guide.id, image: image)
            self.tour_images_qty += 1 if new_image.save
          end
        end
      end
    end
  end
end