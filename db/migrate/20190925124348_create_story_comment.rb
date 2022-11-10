class CreateStoryComment < ActiveRecord::Migration[5.2]
  def change
    create_table :story_comments do |t|
      t.integer "story_id"
      t.integer "user_id"
      t.text "text"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
