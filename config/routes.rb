Rails.application.routes.draw do
  resources :webhooks, only: %i[index show create destroy]
  post "webhooks/:source", to: "webhooks#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
