SiftLaw::Application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
  end
  
  resources :companies do
    member do
      get :profile
    end
  end
  resources :users
  
  get "cities/index", as: "cities"

  get 'home/index'
  
  root :to => 'home#index'
end
