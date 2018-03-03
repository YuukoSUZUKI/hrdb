json.extract! user, :id, :account, :authority, :token, :created_at, :updated_at
json.url user_url(user, format: :json)
