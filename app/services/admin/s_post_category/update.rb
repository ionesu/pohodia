module Admin
  module SPostCategory
    class Update

      attr_accessor :administrator, :post_category, :params

      def initialize(administrator, post_category_id, params)
        @administrator = administrator
        @post_category = PostCategory.find_by(id: post_category_id)
        @params = params
      end

      def call
        if post_category
          post_category.update_attributes(params)
        end
      end

    end
  end
end