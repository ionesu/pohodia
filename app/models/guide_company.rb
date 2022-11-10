# == Schema Information
#
# Table name: guide_companies
#
#  id               :bigint(8)        not null, primary key
#  title_ru         :string           not null
#  title_en         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  country_id       :integer
#  region_id        :integer
#  city_id          :integer
#  logo             :string
#  address_ru       :string
#  address_en       :string
#  main_phone       :string
#  additional_phone :string
#  email            :string
#  description_ru   :text
#  description_en   :text
#  site             :string
#

class GuideCompany < ApplicationRecord
  mount_uploader :logo, GuideCompanyLogoUploader

  has_many :guide_company_permissions
  has_many :tours

  belongs_to :country, optional: true
  belongs_to :region, optional: true
  belongs_to :city, optional: true
end
