Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  get 'dashboard', to: 'projects#index', as: :dashboard
  resources :projects, except: :index
  resource :profile, only: [:show, :edit, :update]
  resource :creditcard, only: [:create]
  resource :payment, only: :create
  resources :user_projects, only: :update
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
