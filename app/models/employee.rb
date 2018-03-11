class Employee < ApplicationRecord
  belongs_to :user
  
  has_many :talents ,through: :user
  has_many :skill ,through: :talents
  has_many :skill_category ,through: :skill

  scope :name_like, -> name {
    where(arel_table[:name].matches "%#{name}%")
  }
end
