Rails.application.routes.draw do
  get 'features' => 'feature_request#index'
  get 'home' => 'home#index', as: 'home'

  devise_for :users, controllers: { sessions: 'sessions' }

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: 'home_signed'
    end
    unauthenticated :user do
      root 'sessions#new', as: 'sign_in'
    end
  end
end
