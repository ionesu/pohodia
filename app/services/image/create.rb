class Image::Create
  MAX_COUNT_IMAGES = 9

  attr_accessor :story, :images, :counter

  def initialize(story, images)
    @story = story
    @images = images
    @counter = story.images.count
  end

  def call
    return if images.blank?

    if counter < MAX_COUNT_IMAGES && images.size > 0
      images.each do |image|
        if counter < MAX_COUNT_IMAGES
          StoryImage.create!(story: story, image: image)
          self.counter += 1
        end
      end
    end
  end
end
