json.extract! politician, :id, :name, :birthdate, :party, :photo, :created_at, :updated_at
json.url politician_url(politician, format: :json)
