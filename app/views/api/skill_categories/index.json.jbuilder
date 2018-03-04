json.skill_categories do
  # json.array!(配列) do |要素名| end を使うと、
  # 配列構造を作ることができる
  json.array!(@skill_categories) do |skill_category|
    json.(skill_category, :id, :skill_category_name, :sort_order)
    json.skills(skill_category.skills, :id, :skill_name, :has_learning_level) 
    
#    json.extract! skill_category, :id, :skill_category_name, :sort_order
#    
#    json.array!(skill_category(:skills)) do |skill|
#      json.extract! skill, :id, :skill_name, :has_learning_level
#    end
  end
end

