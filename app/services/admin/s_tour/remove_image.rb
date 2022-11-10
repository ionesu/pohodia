module Admin
  module STour
    class RemoveImage
      def initialize(administrator, tour_id,  image_id)
        @administrator = administrator
        @tour = Tour.find_by(id: tour_id)
        @image = @tour.tour_images.find_by(id: image_id)
      end

      def main
        if @administrator and administrator_has_permissions? and @tour and @image
          remove_image ? @tour : false
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

      def remove_image
        @image.removed = true
        @image.save
      end
    end
  end
end