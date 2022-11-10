class GuidesController < ApplicationController
  layout "guide"

  before_action :authenticate_guide!
  before_action :all_pages_data

  def dashboard
    # render 'guides/dashboard'
  end

  protected

  def pundit_user
    current_guide
  end

  private

  def all_pages_data
    set_meta_tags noindex: true, nofollow: true, nofollow: 'googlebot'
  end
end