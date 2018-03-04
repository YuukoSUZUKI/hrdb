Rails.application.routes.draw do
  #resources :talents
  #resources :employees
  #resources :users
  root to: 'home#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  # API用のエンドポイント設定
  namespace :api, format:'json' do
    resources :skill_categories, only: [:index]
    resources :skills, only: [:show, :new, :create]
    resources :users
    resources :user_details, only: [:show, :edit, :update]
    resources :employees, only: [:show, :edit, :update, :create]
    
  end
end
