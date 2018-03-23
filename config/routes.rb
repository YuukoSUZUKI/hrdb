Rails.application.routes.draw do
  resources :talents
  resources :employees
  resources :users
  root to: 'home#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  # API用のエンドポイント設定
  namespace :api, format:'json' do

    #ログイン
    post 'login/login'
    
    #スキル検索
    get 'user/list', to: 'users#searchSimple', controller: 'users'
    #スキルオートコンプリート
    get 'skill/list', to: 'skills#wordMarches', controller: 'skills'
    #スキルシート編集表示
    get 'employees/me', to: 'employees#showMe', controller: 'employees'

    resources :skill_categories, only: [:index]
    resources :skills, only: [:show, :new, :create]
    resources :users
    resources :user_details, only: [:show, :edit, :update]
    resources :employees, only: [:show, :edit, :update, :create]
    
    
  end
end
