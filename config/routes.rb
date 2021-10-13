Rails.application.routes.draw do
  get 'pets_toggle/index'
  devise_for :users, controllers: {registrations: "registrations"}
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :pets do
    delete 'pets/:id/image_remove', to: 'pets#remove_image', as: 'pet_image_remove'
    get '/pets/:id/image_remove' => 'pets#remove_image'
  end
  delete 'pets/:id/delete' => 'pets#destroy', as: 'pets_delete'
  get '/pets/:id/delete' => 'pets#destroy'

  resources :found_pets

  root "home#index"
  get  'about/index', to:'about#index'
  get  'contact/index', to:'contact#index'

end