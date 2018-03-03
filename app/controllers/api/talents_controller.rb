#Talent 人事スキルと人材の紐づけ
class Api::EmployeesController < ApplicationController
  #include ActionController::HttpAuthentication::Token::ControllerMethods #TODO:認証するようになったらコメント外す
  before_action :authenticate

  def new
    @form = Form::TalentCollection.new
  end
  
  def create
    @form = Form::TalentCollection.new(talent_collection_params)
    if @form.save
  #    redirect_to
    end
  end
  
    #認証
    def authenticate
      true
#    authenticate_token do |token, options| #TODO:認証するようになったらコメント外す。tokenフィールド名はDBに合わせて修正する。
#      auth_user=User.find_by(token:token)
#      auth_user != nil ? true : false
#    end
    end
end


