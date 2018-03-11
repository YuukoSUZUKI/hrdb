class Employee < ApplicationRecord
  belongs_to :user
  
  has_many :talents ,through: :user

  scope :name_like, -> name {
    where(arel_table[:name].matches "%#{name}%")
  }
end
