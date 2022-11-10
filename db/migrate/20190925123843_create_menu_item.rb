class CreateMenuItem < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.integer "menu_id"
      t.string "title_ru"
      t.string "title_en"
      t.string "link_ru"
      t.string "link_en"
      t.integer "position", default: 0, null: false
      t.index ["link_en"], name: "index_menu_items_on_link_en"
      t.index ["link_ru"], name: "index_menu_items_on_link_ru"
      t.index ["menu_id"], name: "index_menu_items_on_menu_id"
      t.index ["position"], name: "index_menu_items_on_position"
      t.index ["title_en"], name: "index_menu_items_on_title_en"
      t.index ["title_ru"], name: "index_menu_items_on_title_ru"
    end
  end
end
