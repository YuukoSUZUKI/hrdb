Rails.application.routes.draw do
  resources :tarents
  resources :employees
  resources :skills
  resources :users
  resources :skill_categories
  root to: 'home#index'
  
  resources :talents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    get "/" => "home#index"
    get "skill_categories/"=>"skill_categories#index"
    get "skills/"=>"skills#index"
    get "users/"=>"users#index"
end
