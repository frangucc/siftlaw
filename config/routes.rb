SiftLaw::Application.routes.draw do
  get "favorites/index"

  devise_for :users
  
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
  end
  
  resources :companies do
    member do
      get :favorite
      get :profile
    end
  end
  
  resources :users do
    collection do
      get "delete_favorites"
    end
  end
  
  get "cities/index", as: "cities"
  get "favorites/index", as: "favorites"
  get 'home/index'
  
  match 'search' => 'home#search', as: "search"
  
  root :to => 'home#index'
end
