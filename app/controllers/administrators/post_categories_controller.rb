class Administrators::PostCategoriesController < AdministratorsController

  before_action :get_post_category, only: [:edit, :update, :destroy]

  def index
    @post_categories = PostCategory.all
  end

  def edit; end

  def update
    Admin::SPostCategory::Update.new(current_administrator, params[:id], post_category_params).call
    redirect_back(fallback_location: administrator_root_path)
  end

  def destroy
    if PostCategory.all.size > 1
      category = PostCategory.where.not(id: @post_category.id).first
      @post_category.posts.update_attribute(id: category.id)
      @post_category.destroy
    end
    redirect_back(fallback_location: administrator_root_path)
  end

  def new
    @post_category = PostCategory.new
  end

  def create
    result = Admin::SPostCategory::Create.new(current_administrator,  post_category_params).call
    if result
      redirect_to edit_administrators_post_category_path(result)
    else
      redirect_back(fallback_location: administrator_root_path)
    end
  end

  private

  def get_post_category
    @post_category = PostCategory.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:title_ru, :title_en, :description_ru, :description_en, :avatar, :large_avatar,
                                          :slug_ru, :slug_en, :meta_title_ru, :meta_title_en, :meta_description_ru,
                                          :meta_description_en, :meta_keywords_ru, :meta_keywords_en)
  end
end