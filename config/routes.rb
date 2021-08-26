Rails.application.routes.draw do
  devise_for :users
  resources :pets do
    delete 'remove_image', to: 'pets#remove_image'
  end

  root "home#index"
end