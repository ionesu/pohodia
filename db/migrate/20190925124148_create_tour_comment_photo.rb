class CreateTourCommentPhoto < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_comment_photos do |t|
      t.bigint "tour_comment_id"
      t.string "photo"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["tour_comment_id"], name: "index_tour_comment_photos_on_tour_comment_id"
    end
  end
end
