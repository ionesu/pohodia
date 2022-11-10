# == Schema Information
#
# Table name: menu_items
#
#  id       :bigint(8)        not null, primary key
#  menu_id  :integer
#  title_ru :string
#  title_en :string
#  link_ru  :string
#  link_en  :string
#  position :integer          default(0), not null
#

class MenuItem < ApplicationRecord
  belongs_to :menu
end
