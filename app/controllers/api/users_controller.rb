# ユーザ情報の作成・更新。ここでは更新する際に、紐づく社員情報・タレント情報も一度に作成/削除するが、社員情報やタレント情報の編集は、user_detailsで行う。
class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token   #MEMOこれを入れて本当に良い？
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # ユーザ管理
  # GET /users
  # GET /users.json
  def index
    # 氏名 部分一致検索の一覧
    @users = User.has_employee_name_like(search_params[:name])
    render json:{:users => @users, :status => 200}, include: 'employee'
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end
  
  # スキルシート検索
  #GET /user/list
  def searchSimple
    # TODO ファットコントローラー、SQL直書き力技 時間あればいい方法に置き換える
    # SQL直書きの恩恵もあるかも(sql関数大文字小文字吸収・列横断のあいまい検索の要件に対応)
    sql = "SELECT employees.*,
                  employees.id as employee_id
                  FROM users
                    LEFT OUTER JOIN employees
                      ON employees.user_id = users.id
                  WHERE 1=1 "
    #氏名部分一致
    employee_name_like = nil
    if search_params[:name].present? 
      sql.concat(" AND employees.name like :employee_name ")
      employee_name_like = "%" + search_params[:name] + "%"
    end
    
    #指定された保有スキルを全て持っているユーザを絞り込む
    skill_ids = nil
    skill_count = nil
    if search_params[:skills].present? 
        logger.debug('present')
        sql.concat(" AND users.id in (select talents.user_id from talents 
                                      WHERE talents.skill_id in ( :skill_id )
                                      group by talents.user_id 
                                      having count(distinct talents.skill_id) = :count ) ")
        skill_ids = search_params[:skills]
        skill_count = search_params[:skills].length
    end
    #sql サニタイズ
    sanitizedSql = ActiveRecord::Base.send(
      :sanitize_sql_array,
      [
        sql,
        employee_name: employee_name_like,
        skill_id: skill_ids ,
        count: skill_count ,
      ]
    )
    #クエリ実行
    result = ActiveRecord::Base.connection.select_all(sanitizedSql)
    render json:{:users => result, :status => 200}
  end


  # GET /users/new
  def new
    @user = User.new
    @user.employee = Employee.new if @user.employee.blank?
  end

  # GET /users/1/edit
  def edit
    render 'show',formats: 'json', handlers: 'jbuilder'
  end

  # POST /users
  # POST /users.json
  def create
    logger.debug(user_params)
    #userと紐づくemployeeを新規作成
    @user = User.new(user_params)
    @user.save

    if @user.valid?
      render json:{ user: @user, status:200 }
    else
      logger.debug(@user.errors.full_messages)
      # エラーの場合、エラーメッセージのリストとエラーステータスを返却
      render json:{ errors: @user.errors.full_messages } ,status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    logger.debug(user_params)
    # 社員情報の更新、紐づくemployeeも更新
    @user.update(user_params)
    if @user.valid?
      render json:{status:200}
    else
      logger.debug(@user.errors.full_messages)
      # エラーの場合、エラーメッセージのリストとエラーステータスを返却
      render json:{ errors: @user.errors.full_messages } ,status: :unprocessable_entity
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'ユーザを削除しました' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(
        :id, :account, :password, :authority,
        employee_attributes: [:id,:name,:employee_number, :_destroy])
    end
    
    #検索用パラメータ
    def search_params
      params.permit(:name, :skills=>[])
    end
end