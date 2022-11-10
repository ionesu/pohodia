module ContentImage
  include ActiveSupport::Concern

  PUBLIC_PAGE_LIST = [800, 530]
  PUBLIC_PAGE_SHOW = [1600, 485]
  # PUBLIC_PAGE_SHOW = [600, 400]

  if Rails.env.production?
    IMAGE_STORAGE = :fog
  else
    IMAGE_STORAGE = :file
  end

  def self.version_page_list
    "#{PUBLIC_PAGE_LIST[0]}px * #{PUBLIC_PAGE_LIST[1]}px"
  end

  def self.version_page_show
    "#{PUBLIC_PAGE_SHOW[0]}px * #{PUBLIC_PAGE_SHOW[1]}px"
  end
end