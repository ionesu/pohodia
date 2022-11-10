module Admin
  module SRegion
    class Update
      def initialize(administrator, region_id, region_params)
        @administrator = administrator
        @region = Region.find_by(id: region_id)
        @region_params = region_params
      end

      def main
        if @administrator and administrator_has_permissions?
          update_region ? @region : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['regions'] or @administrator.full_access
          true
        else
          false
        end
      end

      def update_region
        @region.update_attributes(@region_params)
        @region.save
      end
    end
  end
end