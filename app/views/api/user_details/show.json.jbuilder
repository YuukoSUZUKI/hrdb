json.set! :employee do
  json.extract! @user.employee, :id,:employee_number,:name,:speciality,:memo,:user
end


#json.id(employee.id)
#json.employee_number(employee.employee_number)
#json.name(employee.name)
#json.speciality(employee.speciality)
#json.memo(employee.memo)
#json.user_id(employee.user_id)

# タレントは入れ子構造
json.talents do
  json.array!(employee.talents) do |talent|
    # 部分テンプレートを表示
    json.partial!(talent)
  end
end