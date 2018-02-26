json.extract! user, :id, :user_name, :password_digest, :authority, :created_at, :updated_at
json.url user_url(user, format: :json)
