module Storiable
  extend ActiveSupport::Concern

  included do
    before_action :set_page, only: :show
  end

  private

  def set_page
    @page = Page.find_by(descriptor: 'stories') || Page.find_by(descriptor: 'blog')
  end
end