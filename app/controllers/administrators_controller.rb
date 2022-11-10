class AdministratorsController < ApplicationController
  before_action :authenticate_administrator!

  layout "administrator"
  
  before_action :all_pages_data

  def dashboard
    #render 'administrators/dashboard'
  end
  
  private

  def all_pages_data
  	set_meta_tags noindex: 'googlebot', nofollow: 'googlebot'
  end
end