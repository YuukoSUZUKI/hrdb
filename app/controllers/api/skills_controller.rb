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
    @skill.has_learning_level=true
    
    logger.debug("skill")
    logger.debug(@skill)

    if @exist.present? 
      render json:{errors: 'already exists.', status: :unprocessable_entity }
    else
      if @skill.save
        render json:{skill: @skill}
      else
        render json:{errors: @skill.errors, status: :unprocessable_entity }
      end
    end

  end

  # 指定キーワードに一致するスキルのリストを取得
  # GET /skill/list
  def wordMarches
    # TODO ファットコントローラー、SQL直書き力技 時間あればいい方法に置き換える
    # SQL直書きの恩恵もあるかも(sql関数大文字小文字吸収・列横断のあいまい検索の要件に対応)
    sql = "SELECT id,skill_name
            FROM skills
            WHERE 1=1 "
    #スキル名部分一致
    skill_name_like = nil
    if search_params[:skill_name].present? 
      sql.concat(" AND skill_name  collate utf8_unicode_ci like :skill_name ")
      skill_name_like = "%" + search_params[:skill_name] + "%"
    end
    # ソート順 検索ワードに前方一致する ＞ スキル名順
    sql.concat(" ORDER by 1=1 ")
    skill_name_like_fowardmatch = nil
    if search_params[:skill_name].present? 
      sql.concat(" , case when skill_name  collate utf8_unicode_ci like :skill_name_order then 0 else 1 end ")
      skill_name_like_fowardmatch = search_params[:skill_name] + "%" # 前方一致
    end
    sql.concat(" , skill_name ")
    
    #sql サニタイズ
    sanitizedSql = ActiveRecord::Base.send(
      :sanitize_sql_array,
      [
        sql,
        skill_name: skill_name_like,
        skill_name_order: skill_name_like_fowardmatch,
      ]
    )
    #クエリ実行
    result = ActiveRecord::Base.connection.select_all(sanitizedSql)
    render json:{:skills => result, :status => 200}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:skill_name, :skill_category_id)
    end

    #検索用パラメータ
    def search_params
      params.permit(:skill_name)
    end
end
