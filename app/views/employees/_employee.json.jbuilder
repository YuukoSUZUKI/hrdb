json.extract! employee, :id, :employee_number, :name, :birthday, :speciality, :memo, :user_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
