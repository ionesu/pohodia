# frozen_string_literal: true

class Site::PostCategoriesController < SiteController
  before_action :set_data

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 7)
    @page = Page.find_by(descriptor: 'blog')
  end

  def show
    @post_category = PostCategory.find(params[:id])
    @posts = @post_category.posts.paginate(page: params[:page], per_page: 7)
  end

  private

  def set_data
    @post_categories = PostCategory.all
    @recent_posts = Post.all.limit(4)
  end
end
