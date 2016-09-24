Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'confirmations' }
  
  devise_scope :user do
    authenticated :user do
      root 'portal/users#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  namespace :portal do
    resources :users
    resources :bookings do
      member do
        get 'cancel'
      end
    end
    resources :conference_rooms do
      resources :bookings
    end
    root to: "users#index"
  end

  root to: 'devise/sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
