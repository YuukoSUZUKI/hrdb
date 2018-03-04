#一覧表示。社員情報は初期表示に必要なものだけ
json.set! :user do
  json.(@user, :id,:account,:password,:authority)
  json.employee(@user.employee, :id, :employee_number,:name)
end

