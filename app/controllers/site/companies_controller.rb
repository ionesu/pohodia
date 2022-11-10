class Site::CompaniesController < SiteController
  include Guastable

  def show
    @company = GuideCompany.find(params[:id])
    @passport = CompanyPassport.new(@company, user_or_guest, @current_locale)
  end
end
