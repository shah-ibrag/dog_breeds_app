Rails.application.routes.draw do
  # Sets the breeds index as the homepage and defines the breeds resources
  root 'breeds#index'  
  resources :breeds, only: [:index, :show]  # Include :index to define breeds_path
  
  # Define a route for the About page
  get 'pages/about', to: 'pages#about', as: 'pages_about'

  # Define sub-breeds as a nested resource under breeds
  resources :breeds do
    resources :sub_breeds, only: [:show]
  end
end
