class CreateTinymceImage < ActiveRecord::Migration[5.2]
  def change
    create_table :tinymce_images do |t|
      t.string "image"
      t.string "hint"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
