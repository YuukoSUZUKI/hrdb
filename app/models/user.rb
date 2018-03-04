class User < ApplicationRecord
  has_secure_token
  
  has_one :employee
  has_many :talents 
  
  accepts_nested_attributes_for :talents, allow_destroy: true
  accepts_nested_attributes_for :employee, allow_destroy: true 
end
