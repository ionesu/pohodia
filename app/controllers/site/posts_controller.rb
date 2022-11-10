class Site::PostsController < SiteController
  def show
    @post = Post.find(params[:id])
    @post_category = @post.post_category if @post
    @post_categories = PostCategory.all
    @recent_posts = Post.all.by_language(I18n.locale).limit(4)
  end
end