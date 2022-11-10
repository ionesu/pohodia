# frozen_string_literal: true

class Users::CallbacksController < Devise::OmniauthCallbacksController
  include CallbackOmniautheble

  %i[facebook vkontakte google_oauth2].each { |provider| provides_callback_for(provider) }
end