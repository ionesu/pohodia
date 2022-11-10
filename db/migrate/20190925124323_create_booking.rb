class CreateBooking < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer "tour_price_item_id"
      t.bigint "user_id"
      t.string "customer_email", limit: 100, null: false
      t.string "customer_phone", limit: 25
      t.string "customer_name", limit: 100
      t.string "customer_comment", limit: 500
      t.boolean "terms_agree", default: false
      t.boolean "privacy_agree", default: false
      t.integer "parties", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "booking_status_id"
      t.integer "tour_id"
      t.index ["booking_status_id"], name: "index_bookings_on_booking_status_id"
      t.index ["tour_price_item_id"], name: "index_bookings_on_tour_price_item_id"
      t.index ["user_id"], name: "index_bookings_on_user_id"
    end
  end
end
