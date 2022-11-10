class Guides::StoriesController < GuidesController
  include Stories

  protected

  def current_person
    current_guide
  end

  def stories_path
    guides_stories_path
  end

  def new_story_path
    new_guides_story_path
  end

  def story_path(story = nil)
    if story.present?
      guides_story_path(story)
    else
      guides_stories_path
    end
  end

  def edit_story_path(story)
    edit_guides_story_path(story)
  end

  def add_images_story_path
    add_images_guides_story_path
  end

  def delete_image_story_path(model, params)
    delete_image_guides_story_path(model, params)
  end

  def story_params
    super.merge(guide: current_person)
  end
end
