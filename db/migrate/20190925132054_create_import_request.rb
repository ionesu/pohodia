class CreateImportRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :import_requests do |t|
      t.string "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
