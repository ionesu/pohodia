module Admin
  module SPage
    class Create
      def initialize(administrator, page_params)
        @administrator = administrator
        @page = Page.new()
        @page_params = page_params
      end

      def main
        if @administrator and administrator_has_permissions?
          update_page ? @page : false
        else
          false
        end
      end

      private

      def administrator_has_permissions?
        if @administrator.role_permissions['static_pages'] or @administrator.full_access
          true
        else
          false
        end
      end

      def update_page
        @page.update_attributes(@page_params)
        @page.save
      end
    end
  end
end