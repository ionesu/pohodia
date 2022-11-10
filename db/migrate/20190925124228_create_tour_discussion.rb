class CreateTourDiscussion < ActiveRecord::Migration[5.2]
  def change
    create_table :tour_discussions do |t|
      t.integer "administrator_id"
      t.integer "tour_id"
      t.text "text"
      t.boolean "confirmed", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
