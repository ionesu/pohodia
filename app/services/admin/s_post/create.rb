module Admin
  module SPost
    class Create

      attr_accessor :administrator, :post, :post_category, :params

      def initialize(administrator, params)
        @administrator = administrator
        @post = Post.new
        @post_category = PostCategory.find_by(id: params[:post_category_id])
        @params = params
      end

      def call
        if post && post_category
          post.update_attributes(params)
          post
        end
      end

    end
  end
end