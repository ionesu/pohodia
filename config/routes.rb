# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators
  get 'administrators/dashboard', as: 'administrator_root'

  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/callbacks'
  }

  get 'users/dashboard', as: 'user_root'
  # редактирование профиля
  match "/users/edit_profile" => "users/profile#edit_profile", via: [:get]
  # обновление профиля
  match "/users/update_profile" => "users/profile#update_profile", via: [:post], as: 'update_profile_users'
  match "/users/refresh" => "users/profile#refresh", via: [:get], as: 'refresh_profile_users'
  # обновление пароля
  match "/users/update_password" => "users/profile#update_password", via: [:post], as: 'update_password_users'

  devise_for :guides, controllers: {
    sessions: 'guides/sessions',
    registrations: 'guides/registrations',
    confirmations: 'guides/confirmations',
    passwords: 'guides/passwords',
    omniauth_callbacks: 'guides/callbacks'
  }
  get 'guides/dashboard', as: 'guide_root'

  root 'site/pages#home'

  post '/tinymce_assets' => 'tinymce_assets#create'

  # редактирование профиля
  match '/guides/edit_profile' => 'guides/profile#edit_profile', via: [:get]

  resources :cities, only: %i[index]
  resources :regions, only: %i[index]

  ### страна -> тип тура  || страна -> тип тура -> категория тура
  # Австралия -> пешие туры
  get '/countries/:id/tour_types/:tour_type_id', to: 'site/countries#tour_type', as: 'tour_type_country'

  # Австралия -> пешие туры -> восхождение
  get '/countries/:id/tour_categories/:tour_category_id', to: 'site/countries#tour_category', as: 'tour_category_country'

  # Австралия -> пешие туры -> гиды
  # get '/countries/:id/tour_types/:tour_type_id/guides', to: 'site/countries#tour_type_guides', as: 'guides_tour_type_country'

  # Австралия -> пешие туры -> восхождение -> гиды
  # get '/countries/:id/tour_categories/:tour_category_id/guides', to: 'site/countries#tour_category_guides', as: 'tour_category_country_guides'

  ### страна -> регион -> тип тура  || страна -> регион -> тип тура -> категория тура
  # Австралия -> Центральный регион -> пешие туры
  get '/regions/:id/tour_types/:tour_type_id', to: 'site/regions#tour_type', as: 'tour_type_region'

  # Австралия -> Центральный регион -> пешие туры -> восхождение
  get '/regions/:id/tour_categories/:tour_category_id', to: 'site/regions#tour_category', as: 'tour_category_region'

  ### страна -> регион -> город -> тип тура  || страна -> регион -> город -> тип тура -> категория тура
  # Австралия -> Центральный регион -> пешие туры
  get '/cities/:id/tour_types/:tour_type_id', to: 'site/cities#tour_type', as: 'tour_type_city'

  # Австралия -> Центральный регион -> пешие туры -> восхождение
  get '/cities/:id/tour_categories/:tour_category_id', to: 'site/cities#tour_category', as: 'tour_category_city'

  # блог
  # (see Site::PostCategoriesController)
  get '/blog', to: 'site/post_categories#index'

  # Dynamic error pages
  get '/404', to: 'site/errors#not_found', via: :all
  get '/422', to: 'site/errors#unacceptable', via: :all
  get '/500', to: 'site/errors#internal_error', via: :all

  # api
  # получение регионов у страны
  match '/api/country_regions' => 'site/api#country_regions', via: [:post]

  # получение городов у региона
  match '/api/region_cities' => 'site/api#region_cities', via: [:post]

  # получение категорий туров у типа тура
  match '/api/tour_type_categories' => 'site/api#tour_type_categories', via: [:post]

  # home page quick search
  match '/api/search_brief' => 'site/api#search_brief', via: [:get]

  namespace :users do
    # (see Users::ProfileController)
    resource :profile, controller: 'profile'
    # (see Users::ResetPasswordsController)
    resource :reset_password, controller: 'reset_passwords'

    resources :stories do
      post 'add_images', on: :member
      post 'delete_image', on: :member
    end
  end

  namespace :administrators do
    resources :pages, only: %i[index create edit update destroy new]
    resources :countries, only: %i[index create edit update] do
      get 'regions', on: :member
      get 'cities', on: :member
      get 'seo_data_items', on: :member
    end
    resources :regions, only: %i[edit update] do
      get 'cities', on: :member
      get 'seo_data_items', on: :member
    end
    resources :cities, only: %i[edit update] do
      get 'seo_data_items', on: :member
    end
    resources :tour_types, only: %i[index edit update] do
      get 'tour_categories', on: :member
      get 'seo_data_items', on: :member
    end
    resources :tour_categories, only: %i[edit update new create index] do
      get 'seo_data_items', on: :member
    end
    resources :tours, only: %i[index create update edit new destroy] do
      resources :tour_comments, only: %i[update destroy]
      resources :tour_comment_photos, only: %i[destroy]
      resources :tour_discussions, only: %i[create] do
        post :decline, on: :member
      end

      post 'confirm', on: :member
      post 'add_images', on: :member
      post 'remove_image', on: :member
      post 'restore_image', on: :member
      post 'add_included_in_price_option', on: :member # добавить опцию "что входит в стоимость"
      post 'remove_included_in_price_option', on: :member # удалить  опцию "что входит в стоимость"
      post 'add_not_included_in_price_option', on: :member # добавить опцию "что НЕ входит в стоимость"
      post 'remove_not_included_in_price_option', on: :member # удалить  опцию "что НЕ входит в стоимость"
      post 'add_equipment', on: :member # добавить необходимое снаряжение
      post 'remove_equipment', on: :member # удалить  необходимое снаряжение
      post 'add_price_item', on: :member # добавить элемент в блок "даты и стоимость"
      post 'remove_price_item', on: :member # удалить элемент из блока "даты и стоимость"
      post 'update_price_item', on: :member # обновить элемент из блока "даты и стоимость"
      post 'add_tour_route', on: :member # добавить нитку маршрута
      post 'remove_tour_route', on: :member # удалить нитку маршрута
      post 'update_tour_route', on: :member # обновить нитку маршрута
    end
    resources :seo_data_items, only: %i[update edit update] do
      post 'create_for_country', on: :member # создать сео-странцицу для связки
      # cтрана -> тип тура | страна -> категория тура
    end
    resources :post_categories, except: [:show]
    resources :posts, except: [:show]
    resources :tour_comments, only: %i[index]
    resources :users, only: %i[index]
    resources :guides, only: %i[index]
  end

  namespace :guides do
    # (see Guides::ResetPasswordsController)
    resource :reset_password, controller: 'reset_passwords'

    resources :bookings, only: %i[index]

    resources :stories do
      post 'add_images', on: :member
      post 'delete_image', on: :member
    end

    resources :tours, only: %i[index create update edit new destroy] do
      resources :tour_discussions, only: %i[update]

      post 'restore', on: :member
      post 'create_xml', on: :collection
      get 'refresh_price_items', on: :member
      get 'refresh_options', on: :member
      get 'refresh_routes', on: :member
      get 'refresh_gallery', on: :member
      get 'refresh_base_info', on: :member
      post 'add_images', on: :member
      post 'delete_image', on: :member
      post 'add_tour_option', on: :member
      post 'update_tour_option', on: :member
      post 'delete_tour_option', on: :member
      post 'add_tour_route', on: :member # добавить нитку маршрута
      post 'delete_tour_route', on: :member # удалить нитку маршрута
      post 'update_tour_route', on: :member # обновить нитку маршрута
      post 'add_price_item', on: :member # добавить элемент в блок "даты и стоимость"
      post 'delete_price_item', on: :member # удалить элемент из блока "даты и стоимость"
      post 'update_price_item', on: :member # обновить элемент из блока "даты и стоимость"
    end
    resources :companies, only: %i[index create update edit new destroy] do
      post 'add_guide', on: :member # добавить гида к компании
      post 'update_guide', on: :member # обновить права гида в компании
      post 'delete_guide', on: :member # удалить гида из компании
      get 'tours', on: :member # туры компании
    end

    resources :tour_routes do
      resources :tour_route_points, only: [:create, :destroy] do
        collection { delete :destroy }
      end
    end

    resources :tour_comments, only: %i[index]
  end

  resources :favorites, only: %i[index create], controller: 'site/favorites'

  # туры в корзине
  match '/guides/tours/trash' => 'guides/tours#trash', via: [:get]

  # обновление профиля
  match '/guides/update_profile' => 'guides/profile#update_profile', via: [:post], as: 'update_profile_guides'
  match '/guides/refresh' => 'guides/profile#refresh', via: [:get], as: 'refresh_profile_guides'

  # обновление пароля
  match '/guides/update_password' => 'guides/profile#update_password', via: [:post], as: 'update_password_guides'

  # добавить дополнительный язык
  match '/guides/add_additional_language' => 'guides/profile#add_additional_language',
        via: [:post], as: 'add_additional_language_guides'

  # удалить дополнительный язык
  match '/guides/delete_additional_language' => 'guides/profile#delete_additional_language',
        via: [:post], as: 'delete_additional_language_guides'

  scope module: 'site' do
    resources :guides, only: [:show]
    resources :companies, only: [:show]
    resources :users, only: [:show]

    resources :stories, only: %i[index show] do
      resources :story_comments, only: [:create]
    end

    namespace :stories do
      resources :countries, only: %i[show]
      resources :regions, only: %i[show]
      resources :cities, only: %i[show]
      resources :activities, only: %i[show]
    end

    resources :countries, only: %i[index show] do
      get 'guides', on: :member
    end
    resources :regions, only: [:show] do
      get 'guides', on: :member
    end
    resources :cities, only: [:show] do
      get 'guides', on: :member
    end
    resources :tour_types, only: %i[index show]
    resources :tour_categories, only: %i[index show]
    resources :pages, only: [:show]
    resources :tours, only: %i[index show update] do
      post :search, on: :collection
      get :favorite, on: :member
      resources :tour_comments, only: [:create]
      resources :tour_routes, only: [:index]
    end
    resources :post_categories, only: [:show]
    resources :posts, only: [:show]
    resources :bookings, only: [:create], defaults: { format: 'json' }
  end
end
