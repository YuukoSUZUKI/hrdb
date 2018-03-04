class Api::SkillsController < ApplicationController
  skip_before_action :verify_authenticity_token   #MEMOこれを入れて本当に良い？
  before_action :set_skill, only: [:show]

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end
  
  # POST /skills
  # POST /skills.json
  def create
    # 検証。同一スキルカテゴリIDかつ同一スキル名を持っている場合はエラー
    @exist = Skill.where(skill_category_id: skill_params[:skill_category_id]).where(skill_name: skill_params[:skill_name])

    @skill = Skill.new(skill_params)

    respond_to do |format|
      if @exist.present? 
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      else
        if @skill.save
          format.html { redirect_to api_skill_url(@skill), notice: 'スキルを追加しました' }
          format.json { render :show, status: :created }
        else
          format.html { render :new }
          format.json { render json: @skill.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:skill_name, :has_learning_level, :skill_category_id)
    end
end
