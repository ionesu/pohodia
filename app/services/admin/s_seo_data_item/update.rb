module Admin
  module SSeoDataItem
    class Update
      def initialize(administrator, item_id, params)
        @administrator = administrator
        @seo_data_item = SeoDataItem.find_by(id: item_id)
        @params = params
      end

      def main
        if administrator_has_permissions? and @seo_data_item

          update_seo_data_item ? @seo_data_item : false
        else
          # raise('bad')
          false
        end
      end

      private

      def administrator_has_permissions?
        @administrator.role_permissions['seo_pages'] or @administrator.full_access
      end

      def update_seo_data_item
        @seo_data_item.update_attributes(@params)
        @seo_data_item.save
      end
    end
  end
end