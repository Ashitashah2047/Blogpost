json.extract! post, :id, :title, :body, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
