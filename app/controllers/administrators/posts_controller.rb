class Administrators::PostsController < AdministratorsController

  before_action :get_post, only: [:edit, :update, :destroy]
  before_action :get_post_categories, only: [:edit, :new]

  def index
    @posts = Post.all.includes(:post_category)
  end

  def edit;
  end

  def update
    prm = post_params
    result = Admin::SPost::Update.new(current_administrator, params[:id], prm).call
    notice_message = result ? 'Информация обновлена' : 'Произошла ошибка'
    redirect_back(fallback_location: administrator_root_path)
  end

  def destroy
    @post.destroy
    redirect_back(fallback_location: administrator_root_path)
  end

  def new
    @post = Post.new
  end

  def create
    prm = post_params
    result = Admin::SPost::Create.new(current_administrator, prm).call
    if result
      redirect_to edit_administrators_post_path(result)
    else
      redirect_back(fallback_location: administrator_root_path)
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def get_post_categories
    @post_categories = PostCategory.all.collect { |category| [category.title_ru, category.id] }
  end

  def post_params
    params.require(:post).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                 :slug_ru, :slug_en, :meta_title_ru, :meta_title_en, :meta_description_ru,
                                 :meta_description_en, :meta_keywords_ru, :meta_keywords_en, :lead_ru, :lead_en,
                                 :post_category_id)
  end
end