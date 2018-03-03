class ApplicationController < ActionController::Base
  #include ActionController::HttpAuthentication::Token::ControllerMethods #TODO:認証するようになったらコメント外す
  before_action :authenticate
  protect_from_forgery with: :exception
  
    
  #認証
  def authenticate
      true
#    authenticate_token do |token, options| #TODO:認証するようになったらコメント外す。tokenフィールド名はDBに合わせて修正する。
#      auth_user=User.find_by(token:token)
#      auth_user != nil ? true : false
#    end
  end
end
