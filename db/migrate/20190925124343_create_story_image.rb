class CreateStoryImage < ActiveRecord::Migration[5.2]
  def change
    create_table :story_images do |t|
      t.integer "story_id"
      t.string "image"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "removed", default: false
    end
  end
end
