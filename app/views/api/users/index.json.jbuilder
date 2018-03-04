json.users do
  # json.array!(配列) do |要素名| end を使うと、
  # 配列構造を作ることができる
  json.array!(@users) do |user|
    json.(user, :id, :account, :authority, :password, :token)
    json.emloyee(user.employee, :id, :employee_number, :name, :speciality, :memo) 
    # MEMO talentは要らない？
  end
end

