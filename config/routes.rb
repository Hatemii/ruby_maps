Rails.application.routes.draw do
  resources :pets
  root "home#index"
end