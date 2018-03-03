#社員情報
class Api::EmployeesController < ApplicationController

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
    render 'edit',formats: 'json', handlers: 'jbuilder'
  end

  # 更新
  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    
    #employee_paramsからtalents以外の部分を取得、update
    @employee.employee_number = employee_params.employee_number

    #タレント情報の一括削除、タレントの一括更新
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: '社員情報の更新に成功しました。' }
        format.json { render :show, status: :ok, location: @employee }
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
    end

    #社員パラメータ
    def employee_params
      params.require(:employee).permit(:employee_number, :name, :birthday, :speciality, :memo)
#TODO:できればtalentsが配列であるだけではなく、idがあることも確認したい。
#      params.require(:employee).permit(:employee_number, :name, :birthday, :speciality, :memo, talents:[])
    end
    
    #タレントの配列パラメータ(内容もチェック)
    def talents_params
      params.require(:talents).map { |t| t.permit(:learning_level, :talent, :user) }
    end
end


