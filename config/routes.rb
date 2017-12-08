Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # get 'profile', to: 'pages#profile', as: :profile
  resources :projects
  resource :profile, only: [:show, :edit, :update]
  resource :creditcard, only: [:create]
  resource :payment, only: :create
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
