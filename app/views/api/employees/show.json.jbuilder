#json.set! :employee do
#  json.extract! @employee, :id,:employee_number,:name,:birthday,:speciality,:memo,:user,:created_at,:updated_at
#end

json.partial!(@employee)