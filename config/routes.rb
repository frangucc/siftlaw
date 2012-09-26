SiftLaw::Application.routes.draw do
  get "cities/index", as: "cities"

  get 'home/index'
  
  root :to => 'home#index'
end
