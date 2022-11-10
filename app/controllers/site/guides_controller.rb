class Site::GuidesController < SiteController
  include Guastable

  def show
    @guide = Guide.find(params[:id])
    @passport = GuidePassport.new(@guide, user_or_guest, @current_locale)
  end
end
