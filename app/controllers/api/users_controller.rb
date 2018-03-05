# ユーザ情報の作成・更新。ここでは更新する際に、紐づく社員情報・タレント情報も一度に作成/削除するが、社員情報やタレント情報の編集は、user_detailsで行う。
class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token   #MEMOこれを入れて本当に良い？
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
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
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to api_user_url(@user), notice: 'ユーザ情報を作成しました' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to api_user_url(@user), notice: 'ユーザ情報を更新しました。' }
        format.json { render :show, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
      params.require(:user).permit(:account, :password,:authority,  employee_attributes: [:employee_number, :name,:id,:_destroy])
    end

end