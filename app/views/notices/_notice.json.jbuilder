json.extract! notice, :id, :title, :url, :created_at, :updated_at
json.url notice_url(notice, format: :json)
