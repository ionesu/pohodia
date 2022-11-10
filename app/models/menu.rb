# == Schema Information
#
# Table name: menus
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  descriptor :string
#

class Menu < ApplicationRecord
  include Cacheble

  has_many :menu_items

  def self.scope_for_cache
    includes(:menu_items)
  end
end
