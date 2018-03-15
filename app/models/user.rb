class User < ApplicationRecord
  has_secure_token
  
  has_one :employee
  accepts_nested_attributes_for :employee, allow_destroy: true 

  has_many :talents 
  accepts_nested_attributes_for :talents, allow_destroy: true
  
  scope :has_employee_name_like, -> employee_name {
    joins(:employee).merge(Employee.name_like employee_name)
  }
  
  scope :has_skill_ids_are, -> ids {
    joins(:talents).merge(Talent.skill_ids_are, ids)
  } 
end
