Rails.application.routes.draw do
  devise_for :users, only: [:omniauth_callbacks, :session], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'home#index'
end
