class CountryAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include ContentImage
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
  
  version :page_edit_half do
    process resize_to_fill: [400,265]
  end
  
  version :page_edit_big do
    process resize_to_fill: [600,398]
  end
  
  version :page_edit_full do
    process resize_to_fill: [800,530]
  end

  version :public_page_show do
    process resize_to_fill: PUBLIC_PAGE_SHOW
  end

  version :public_page_list do
    process resize_to_fill: [60, 60]
  end
end
