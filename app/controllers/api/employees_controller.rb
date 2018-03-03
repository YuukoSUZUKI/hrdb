#社員情報
class Api::EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token   #MEMOこれを入れて本当に良い？
  before_action :set_employee, only: [:show, :edit, :update]

  # 一覧表示
  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # 編集 指定idの社員情報を検索して、画面側にrender
  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
    render 'show',formats: 'json', handlers: 'jbuilder'
  end

  # 更新
  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    #タレント情報の一括削除、タレントの一括更新
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to api_employee_url(@employee), notice: '社員情報の更新に成功しました。' }
        format.json { render :show, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # 社員情報を変数に設定
    def set_employee
      @employee = Employee.find(params[:id])
#      @talents = Talent.find(@employee.id)
    end

    #社員パラメータ
    def employee_params
#TODO:birthdayは未決定なのでパラメータから外す。
      params.require(:employee).permit(:employee_number, :name, :speciality, :memo)
#できればtalentsが配列であるだけではなく、idがあることも確認したい。
#      params.require(:employee).permit(:employee_number, :name, :speciality, :memo, talents:[])
    end
    
    #タレントの配列パラメータ(内容もチェック)
    def talents_params
      params.require(:talents).map { |t| t.permit(:learning_level, :talent, :user) }
    end
end


