class CreateGuideCompanyPermission < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_company_permissions do |t|
      t.integer "guide_company_id", null: false
      t.integer "guide_id", null: false
      t.boolean "access_to_tours", default: false, null: false
      t.boolean "access_to_company_info", default: false, null: false
      t.boolean "full_access", default: false, null: false
      t.index ["access_to_company_info"], name: "index_guide_company_permissions_on_access_to_company_info"
      t.index ["access_to_tours"], name: "index_guide_company_permissions_on_access_to_tours"
      t.index ["full_access"], name: "index_guide_company_permissions_on_full_access"
      t.index ["guide_company_id"], name: "index_guide_company_permissions_on_guide_company_id"
      t.index ["guide_id"], name: "index_guide_company_permissions_on_guide_id"
    end
  end
end
