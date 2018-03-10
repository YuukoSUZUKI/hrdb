class Talent < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  
  scope :skill_ids_are , -> ids {
    where([:skill_id].in(ids))
  }
end
