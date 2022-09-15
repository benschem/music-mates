Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#landing"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :concerts, only: %i[index show] do
    resources :groups, only: %i[create new]
  end
  resources :groups, only: :show do
    resources :chatrooms, only: %i[show create] do
      resources :messages, only: :create
    end
  end
  # group_id/chatroom
  resources :invitations, only: %i[index]
end
