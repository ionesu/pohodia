module CallbackOmniautheble
  extend ActiveSupport::Concern

  module ClassMethods
    def provides_callback_for(provider)
      class_eval %Q{
        def #{provider}
          resource_class = request.env['omniauth.params']['type'].eql?('users') ? User : Guide
          current_user = request.env['omniauth.params']['type'].eql?('users') ? current_user : current_guide
          @user = resource_class.find_for_oauth(request.env["omniauth.auth"], current_user)

          if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
          else
            session["devise.#{provider}_data"] = env["omniauth.auth"]
            if request.env['omniauth.params']['main'].present?
              redirect_to root
            else
              redirect_to new_user_registration_url
            end
          end
        end
      }
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && request.env['omniauth.params']['main'].present?
      root_path
    else
      super
    end
  end
end