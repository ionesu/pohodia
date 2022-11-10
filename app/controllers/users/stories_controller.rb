# frozen_string_literal: true

class Users::StoriesController < UsersController
  # before_action :set_story, only: [:edit, :update, :show, :destroy, :add_images, :delete_image]
  #
  # def index
  #   @stories = current_user.stories
  # end
  #
  # def new
  #   @story = Story.new
  #   @countries = smart_collect_for_select(Country.all.select(:id, :title_ru, :title_en).order(:id))
  # end
  #
  # def create
  #   @story = Story.new(story_params.merge(user: current_user))
  #   @story.save
  #   redirect_to edit_users_story_path(@story)
  # end
  #
  # def edit
  # end
  #
  # def update
  #   @story.update(story_params)
  #   redirect_to edit_users_story_path(@story)
  # end
  #
  # def destroy
  #   if @story.destroy
  #     redirect_to users_stories_path
  #   else
  #     head :unprocessable_entity
  #   end
  # end
  #
  # def add_images
  #   Image::Create.new(@story, params[:story][:images]).call
  # end
  #
  # def delete_image
  #   @image = @story.story_images.find(params[:image_id])
  #   @image.update(removed: true)
  #
  #   redirect_to edit_users_story_path(@story)
  # end
  #
  # private
  #
  # def set_story
  #   @story = Story.find(params[:id])
  # end
  #
  # def story_params
  #   params
  #     .require(:story)
  #     .permit(
  #       :title_ru, :title_en, :text_ru, :text_en, :country_id,
  #       :region_id, :city_id, :tour_category_id, :image, :large_image
  #     )
  # end

  include Stories

  protected

  def current_person
    current_user
  end

  def stories_path
    users_stories_path
  end

  def new_story_path
    new_users_story_path
  end

  def story_path(story = nil)
    if story.present?
      users_story_path(story)
    else
      users_stories_path
    end
  end

  def edit_story_path(story)
    edit_users_story_path(story)
  end

  def add_images_story_path
    add_images_users_story_path
  end

  def delete_image_story_path(model, params)
    delete_image_users_story_path(model, params)
  end

  def story_params
    super.merge(user: current_person)
  end
end
