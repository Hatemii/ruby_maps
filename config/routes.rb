Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :pets do
    delete 'remove_image', to: 'pets#remove_image'
  end
  delete 'pets/:id/delete' => 'pets#destroy', as: 'pets_delete'
  get '/pets/:id/delete' => 'pets#destroy'

  root "home#index"
  get  'about/index', to:'about#index'
  get  'contact/index', to:'contact#index'

end