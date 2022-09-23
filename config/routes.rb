Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#landing"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "home", to: "pages#home"


  resources :concerts, only: %i[index show] do
    collection do
      patch :fetch_concerts
    end
    resources :groups, only: %i[create new]
  end

  resources :groups, only: %i[index show] do
    resources :chatrooms, only: %i[create] do
      resources :messages, only: :create
    end
  end

  get "groups/:id/chatroom", to: "chatrooms#show", as: :chatroom

  # group_id/chatroom
  resources :invitations, only: %i[index] do
    member do
      patch :accept
      patch :decline
    end
  end
  resources :profiles, only: :show

  get "search", to: "profiles#search", as: "search"
end
