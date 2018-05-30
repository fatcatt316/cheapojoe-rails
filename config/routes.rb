Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :yard_sales, only: [:index, :create]

  root 'yard_sales#index'
end
