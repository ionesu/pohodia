class RegionAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  require 'carrierwave/storage/fog'

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :page_edit do
    process resize_to_fill: [203,130]
  end

  version :public_page_list do
    process resize_to_fill: [60, 60]
  end
end
