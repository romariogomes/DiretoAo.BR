json.extract! comment, :id, :description, :comment_father, :created_at, :updated_at
json.url comment_url(comment, format: :json)
