class CreateMenu < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string "title"
      t.string "descriptor"
      t.index ["descriptor"], name: "index_menus_on_descriptor"
      t.index ["title"], name: "index_menus_on_title"
    end
  end
end
