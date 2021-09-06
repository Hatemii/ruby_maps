Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :pets do
    delete 'remove_image', to: 'pets#remove_image'
  end

  root "home#index"
  get  'about/index', to:'about#index'
  get  'contact/index', to:'contact#index'

end