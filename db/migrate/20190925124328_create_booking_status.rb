class CreateBookingStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_statuses do |t|
      t.string "title_ru", limit: 100
      t.string "title_en", limit: 100
      t.string "code", limit: 25
      t.index ["code"], name: "index_booking_statuses_on_code"
    end
  end
end
