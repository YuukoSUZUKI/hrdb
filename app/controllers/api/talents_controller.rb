#Talent 人事スキルと人材の紐づけ
class Api::EmployeesController < ApplicationController


  def new
    @form = Form::TalentCollection.new
  end
  
  def create
    @form = Form::TalentCollection.new(talent_collection_params)
    if @form.save
  #    redirect_to
    end
  end

end


