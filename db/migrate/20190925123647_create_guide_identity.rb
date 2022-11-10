class CreateGuideIdentity < ActiveRecord::Migration[5.2]
  def change
    create_table :guide_identities do |t|
      t.bigint "guide_id"
      t.string "provider"
      t.string "uid"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["guide_id"], name: "index_guide_identities_on_guide_id"
    end
  end
end
