json.extract! employee, :id, :employee_number, :birthday, :speciality, :memo, :user, :created_at, :updated_at
json.url employee_url(employee, format: :json)
