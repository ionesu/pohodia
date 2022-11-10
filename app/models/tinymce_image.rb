# == Schema Information
#
# Table name: tinymce_images
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  hint       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TinymceImage < ApplicationRecord
  mount_uploader :image, TinymceImageUploader 
end
