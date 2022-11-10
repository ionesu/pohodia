class CreateUserIdentity < ActiveRecord::Migration[5.2]
  def change
    create_table :user_identities do |t|
      t.bigint "user_id"
      t.string "provider"
      t.string "uid"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_user_identities_on_user_id"
    end
  end
end
