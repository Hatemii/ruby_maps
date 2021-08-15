Rails.application.routes.draw do
  resources :pets do
    delete 'remove_image', to: 'pets#remove_image'
  end

  root "home#index"
end