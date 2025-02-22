Rails.application.routes.draw do
  resources :characters
  resources :time_periods
  get "login", to: "auth#login", as: :login
  get "invite", to: "auth#invite", as: :invite
  get "forgot_password", to: "auth#forgot_password", as: :forgot_password
  get "password_reset", to: "auth#password_reset"
  post "logout", to: "auth#logout", as: :logout

  namespace :auth do
    post "authenticate"
    post "authenticate_token"
    post "complete_invite"
    post "complete_password_reset"
    post "request_password_reset"
  end

  resources :worlds do
    member do
      get :start_editing
    end
  end
  resources :character_types
  resources :character_species_types

  resources :armies
  resources :army_lists do
    member do
      post :attach_equipment
      post :remove_equipment
    end
    resources :units do
      collection do
        get :add_trait_row
      end
    end
  end

  resources :game_systems, only: %i[index]
  namespace :game_systems do
    resources :wargames, except: %i[index] do
      collection do
        get :add_new_stat_row
      end
    end
  end
  resources :equipment

  resources :unit_traits
  resources :unit_trait_categories do
    collection do
      get :add_category_row
    end
  end
  resources :unit_templates do
    collection do
      get :add_trait_row
    end
  end
  resources :unit_stat_modifiers do
    collection do
      get :add_stat_change_row
    end
  end
  resources :unit_xp_gain_events
  resources :players, only: %i[update] do
    member do
      get :add_army_row
    end
  end
  resources :gaming_groups do
    member do
      post :update_membership
      post :remove_user
      post :invite_user
    end

    resources :campaigns
    resources :teams
    resources :teams, only: %i[create update destroy]
    resources :gaming_sessions
  end

  resources :games do
    member do
      get :add_xp_gain_applied_row
      get :add_unit_applied_modifier_row
    end
  end
  resources :users, only: %i[show update] do
    member do
      get :campaigns
    end
    collection do
      post :emulate_user
      post :stop_emulation
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#homepage"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
