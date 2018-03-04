class Api::UserDetailsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  # GET /user_details/1
  # GET /user_details/1.json
  def show
  end

  # GET /user_details/1/edit
  def edit
  end

  # PATCH/PUT /user_details/1
  # PATCH/PUT /user_details/1.json
  def update
    respond_to do |format|
      if @user.update(user_detail_params)
        format.html { redirect_to api_user_url(@user), notice: '人材情報を更新しました。' }
        format.json { render :show, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_detail_params
      params.require(:user).permit(:account, :authority, employee_attributes: [:employee_number, :name, :speciality, :memo,:id], talents_attributes: [:learning_level,:id])
    
    end
end
