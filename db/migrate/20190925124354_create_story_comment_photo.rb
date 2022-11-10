class CreateStoryCommentPhoto < ActiveRecord::Migration[5.2]
  def change
    create_table :story_comment_photos do |t|
      t.integer "story_comment_id", null: false
      t.string "photo"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
