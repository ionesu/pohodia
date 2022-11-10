# == Schema Information
#
# Table name: user_identities
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserIdentity < ApplicationRecord
  belongs_to :user

  class << self
    def find_for_oauth(auth)
      find_or_create_by(uid: auth.uid, provider: auth.provider)
    end
  end
end
