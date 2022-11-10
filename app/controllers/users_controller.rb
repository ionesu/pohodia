class UsersController < ApplicationController
  layout 'user'

	before_action :authenticate_user!  
  before_action :all_pages_data

  def dashboard
    render 'users/dashboard'
  end

  protected
    
  def pundit_user
   current_user
  end
  
  private

  def all_pages_data
  	set_meta_tags noindex: true, nofollow: 'googlebot'
  end
end