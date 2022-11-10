# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
#
Rails.application.config.assets.precompile += %w( site.scss )
Rails.application.config.assets.precompile += %w( site.js )

Rails.application.config.assets.precompile += %w( administrator.scss )
Rails.application.config.assets.precompile += %w( administrator.js )

Rails.application.config.assets.precompile += %w( guide.scss )
Rails.application.config.assets.precompile += %w( guide.js )

Rails.application.config.assets.precompile += %w( guide_sign_in.scss )
Rails.application.config.assets.precompile += %w( guide_sign_in.js )

Rails.application.config.assets.precompile += %w( user_sign_in.scss )
Rails.application.config.assets.precompile += %w( user_sign_in.js )

Rails.application.config.assets.precompile += %w( user.scss )
Rails.application.config.assets.precompile += %w( user.js )

Rails.application.config.assets.precompile += %w( guide/template/selectize.js )
Rails.application.config.assets.precompile += %w( guide/template/remote_form.js )
