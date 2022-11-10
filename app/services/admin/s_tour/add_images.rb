module Admin
  module STour
    class AddImages
      def initialize(administrator, tour_id,  images)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @params_images = images
        @tour_images_size = @tour.tour_images.where(removed: false).size
      end

      def main
        if @administrator and administrator_has_permissions? and @tour_images_size < 8 and @params_images.size > 0
          create_tour_images ? @tour : false
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

      def create_tour_images
        @params_images.each do |image|
          if @tour_images_size < 8
            new_image = TourImage.new(tour_id: @tour.id, administrator_id: @administrator.id, image: image)
            @tour_images_size += 1 if new_image.save
          end
        end
      end
    end
  end
end