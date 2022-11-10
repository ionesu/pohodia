class Guides::CallbacksController < Devise::OmniauthCallbacksController
  include CallbackOmniautheble

  %i[facebook vkontakte google_oauth2].each { |provider| provides_callback_for(provider) }
end