class User < ApplicationRecord

  has_secure_token
  has_secure_password
  
  has_one :employee
  accepts_nested_attributes_for :employee, allow_destroy: true 
  validates_associated :employee

  has_many :talents 
  accepts_nested_attributes_for :talents, allow_destroy: true
  
  # バリデーション
  validates :account, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :authority, presence: true, inclusion: { in: [1,2] }
  
  scope :has_employee_name_like, -> employee_name {
    joins(:employee).merge(Employee.name_like employee_name)
  }
  
  scope :has_skill_ids_are, -> ids {
    joins(:talents).merge(Talent.skill_ids_are, ids)
  } 
end
