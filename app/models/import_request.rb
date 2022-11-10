# == Schema Information
#
# Table name: import_requests
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ImportRequest < ApplicationRecord
  mount_uploader :content, ContentUploader
end
