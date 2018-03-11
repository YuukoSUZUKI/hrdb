class SkillCategory < ApplicationRecord
  has_many :skills
  has_many :talents ,through: :skills

end
