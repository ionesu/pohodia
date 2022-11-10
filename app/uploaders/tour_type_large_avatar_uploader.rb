class TourTypeLargeAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include ContentImage
  require 'carrierwave/storage/fog'

  storage IMAGE_STORAGE

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :page_edit do
    process resize_to_fill: [603,130]
  end

  version :public_page_show do
    process resize_to_fill: PUBLIC_PAGE_SHOW
  end
end
