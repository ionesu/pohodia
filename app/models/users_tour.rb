# == Schema Information
#
# Table name: users_tours
#
#  id      :bigint(8)        not null, primary key
#  user_id :integer
#  tour_id :integer
#

class UsersTour < ApplicationRecord
  belongs_to :user
  belongs_to :tour
end
