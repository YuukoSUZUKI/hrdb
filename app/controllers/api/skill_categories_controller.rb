class Api::SkillCategoriesController < ApplicationController
  before_action :set_skill_category, only: [:show]

  # GET /skill_categories
  # GET /skill_categories.json
  def index
    @skill_categories = SkillCategory.order(:sort_order)
    render json:{:skill_categories => @skill_categories, :status => 200}, include: 'skills'
  end

  # GET /skill_categories/1
  # GET /skill_categories/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_category
      @skill_category = SkillCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_category_params
      params.require(:skill_category).permit(:skill_category_name, :sort_order)
    end
end
