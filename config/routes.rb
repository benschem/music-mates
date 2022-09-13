Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :concerts, only: %i[index show] do
    resources :groups, only: %i[create new show]
  end
  resources :invitations, only: %i[index]
end
