class User < ApplicationRecord
  has_secure_token
  
  has_one :employee
  accepts_nested_attributes_for :employee, allow_destroy: true 

  has_many :talents 
  accepts_nested_attributes_for :talents, allow_destroy: true

end
