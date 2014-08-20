Rails.application.routes.draw do
  #TODO: configure for production later
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, only: [:omniauth_callbacks, :session], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'home#index'
end
