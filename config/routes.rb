SiftLaw::Application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
  end
  
  resource :companies
  resource :users
  
  get "cities/index", as: "cities"

  get 'home/index'
  
  root :to => 'home#index'
end
