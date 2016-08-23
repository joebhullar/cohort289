Rails.application.routes.draw do
  # get 'products/edit' => "products#edit"
  resources :products  #RESOURCES METHOD THAT TAKES IN THE NAME OF THE CONTROLLER
                       #- WE HAVE DEFINED THE 7  ACTIONS FOR CONTROLLER WE HAVE TO DO EACH ONE

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"
end
