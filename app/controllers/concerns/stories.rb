module Stories
  extend ActiveSupport::Concern

  included do
    before_action :set_story, only: [:edit, :update, :show, :destroy, :add_images, :delete_image]

    helper_method :stories_path, :story_path,
                  :new_story_path, :edit_story_path,
                  :add_images_story_path,
                  :delete_image_story_path
  end

  def index
    @stories = current_person.stories
  end

  def new
    @story = Story.new
    @countries = smart_collect_for_select(Country.all.select(:id, :title_ru, :title_en).order(:id))
  end

  def create
    @story = Story.new(story_params)
    @story.save
    redirect_to edit_story_path(@story)
  end

  def edit
  end

  def update
    @story.update(story_params)
    redirect_to edit_story_path(@story)
  end

  def destroy
    if @story.destroy
      redirect_to stories_path
    else
      head :unprocessable_entity
    end
  end

  # TODO: В отдельные ресурс
  def add_images
    Image::Create.new(@story, params.dig(:story, :images)).call
  end

  # TODO: В отдельные ресурс
  def delete_image
    @image = @story.story_images.find(params[:image_id])
    @image.update(removed: true)

    redirect_to edit_story_path(@story)
  end

  private

  def set_story
    @story = current_person.stories.find(params[:id])
  end

  def story_params
    params
      .require(:story)
      .permit(
        :title_ru, :title_en, :text_ru, :text_en, :country_id,
        :region_id, :city_id, :tour_category_id, :image, :large_image
      )
  end
end
