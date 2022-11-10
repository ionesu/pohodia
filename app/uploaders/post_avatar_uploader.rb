class PostAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include ContentImage
  require 'carrierwave/storage/fog'

  storage IMAGE_STORAGE

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :page_edit do
    process resize_to_fill: [203,130]
  end

  version :public_page_list do
    process resize_to_fill: [800, 533]
  end

  version :public_page_list_thumb do
    process resize_to_fill: [120, 80]
  end
end
