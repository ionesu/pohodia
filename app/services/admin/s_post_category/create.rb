module Admin
  module SPostCategory
    class Create

      attr_accessor :administrator, :post_category, :params

      def initialize(administrator, params)
        @administrator = administrator
        @post_category = PostCategory.new
        @params = params
      end

      def call
        post_category.assign_attributes(params)
        if post_category.save
          post_category
        end
      end

    end
  end
end