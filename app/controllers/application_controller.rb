class ApplicationController < ActionController::Base
  # トークン認証
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate ,if: :reqire_authenticate?
  #APIの場合CSRFチェック不用
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
  
  #ログイン中のユーザ情報のインスタンス変数
  @login_user
  
  def json_request?
    request.format.json?
  end
    
  #認証
  def authenticate
    logger.debug('authenticate')
    # Authorization ヘッダのトークンと Users テーブルのtokenを比較して認証
    authenticate_or_request_with_http_token do |token, options|
      @login_user=User.find_by(token:token)
      #トークンが存在して有効期間内なら認証OK
      @login_user != nil && DateTime.now <= @login_user.token_expire ? true : false
    end
  end
  
  #認証の対象外コントローラーでは これをオーバーライドしてfalseを返す
  def reqire_authenticate? 
    true
  end
end
