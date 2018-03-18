class Employee < ApplicationRecord
  belongs_to :user
  
  has_many :talents ,through: :user
  has_many :skill ,through: :talents
  has_many :skill_category ,through: :skill

  # バリデーション
  validates :name, presence: true
  validates :employee_number, uniqueness: true
  
  scope :name_like, -> name {
    where(arel_table[:name].matches "%#{name}%")
  }
end
