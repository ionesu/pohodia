# == Schema Information
#
# Table name: guide_company_permissions
#
#  id                     :bigint(8)        not null, primary key
#  guide_company_id       :integer          not null
#  guide_id               :integer          not null
#  access_to_tours        :boolean          default(FALSE), not null
#  access_to_company_info :boolean          default(FALSE), not null
#  full_access            :boolean          default(FALSE), not null
#

class GuideCompanyPermission < ApplicationRecord
  belongs_to :guide_company
  belongs_to :guide
end
