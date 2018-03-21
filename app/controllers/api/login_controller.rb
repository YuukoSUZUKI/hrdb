class Api::LoginController < ApplicationController
  protect_from_forgery except: :login # デバッグ中はCSRFチェックを除外
  
  #認証不要のコントローラ
  def reqire_authenticate? 
    false
  end
  
  def login

    logger.debug(login_params)
    #ユーザーの存在とパスワードの照合
    login_user = User.find_by(account:login_params[:account])
    if login_user != nil && login_user.authenticate(login_params[:password])
      #ログインに成功したらトークンの生成 とトークン有効期間の設定
      login_user.regenerate_token
      login_user.token_expire = DateTime.now + Rational(1, 24)  # トークン有効期間 1時間
      login_user.save
      render json:{token: login_user.token, status:200}
    else
      # ログインエラー ステータスを返却
      render json:{ errors: ["アカウント・パスワードが一致しません"] } ,status: :unauthorized
    end
  end

  #ログイン用パラメータ
  def login_params
    params.permit(:account,:password)
  end

end
