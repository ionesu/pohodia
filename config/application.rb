require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pohodia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*', '*.{rb,yml}')]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :ru

    config.autoload_paths += %W(#{config.root}/app/facades/s_user)
    config.autoload_paths += %W(#{config.root}/app/facades/s_guide)
    config.autoload_paths += %W(#{config.root}/app/facades/site)
    config.autoload_paths += %W(#{config.root}/app/facades)
    config.autoload_paths += %W(#{config.root}/app/finders)

    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.test_framework :rspec, fixtures: true, views: false
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end
    config.serve_static_assets = false
  end
end
