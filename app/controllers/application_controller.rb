class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_locale, :set_variables

  rescue_from AccessDenied, with: :access_denied_handler

  private

  def set_locale
    I18n.available_locales = [:ru, :en]
    if %w(pohodia-dev.com pohodia.com).include? request.host
      I18n.locale = :en
      Rails.application.config.i18n.locale = :en
    else
      I18n.locale = :ru
      Rails.application.config.i18n.locale = :ru
    end
  end

  def set_variables
    @current_locale = Rails.application.config.i18n.locale
  end

  def access_denied_handler
    render file: "#{Rails.root}/public/500", layout: false, status: :not_found
    true
  end

  protected
    
  def after_sign_in_path_for(resource)
  	case resource.class.name
  	when 'Guide'
    	guide_root_path
    when 'Administrator'
    	administrator_root_path
    else
    	super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end


  def pundit_wrapper(result)
    unless result
      raise "error in pundit"
    end
  end
end
