Rails.application.routes.draw do
  root to: 'home#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  # API用のエンドポイント設定
  namespace :api, format:'json' do
    resources :employees, only: %i(edit) #複数あったら only:[:index,:update]
  end
end
