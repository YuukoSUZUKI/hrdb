class Skill < ApplicationRecord
  belongs_to :skill_category
  
  has_many :talents

  # 指定ユーザIDの人が保有するスキルを絞り込み
  scope :has_user_id_in_category, -> (user_id , skill_category_id) {
    eager_load(:talents)
      .where('talents.user_id = ?', user_id)
      .where('skill_category_id = ?',skill_category_id)
      .order('skill_name')
  }

end
