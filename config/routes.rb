require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  devise_for :users, only: [:omniauth_callbacks, :session], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  authenticated :user do
    #TODO: configure for production later
    mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

    put 'sync', to: 'stared_repos#sync'
    get 'auto_complete_tags', to: 'stared_repos#auto_complete_tags'
    root 'stared_repos#index', as: :user_root
  end

  root 'home#index'
end
