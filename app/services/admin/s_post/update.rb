module Admin
  module SPost
    class Update

      attr_accessor :administrator, :post, :post_category, :params

      def initialize(administrator, post_id, params)
        @administrator = administrator
        @post = Post.find_by(id: post_id)
        @post_category = PostCategory.find_by(id: params[:post_category_id])
        @params = params
      end

      def call
        if post && post_category
          post.update_attributes(params)
        end
      end

    end
  end
end