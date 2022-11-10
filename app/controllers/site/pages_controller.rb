class Site::PagesController < SiteController
  include Guastable

  before_action :set_person, only: [:home]

  # главная страница
  def home
    @page = Page.find_by(descriptor: 'home')
    @page = Site::PublicHomeFacade.new(@page, @current_locale)
  end

  def show
    @page = Page.find(params[:id])
  end

  private

  def set_person
    @person = user_or_guest
  end
end