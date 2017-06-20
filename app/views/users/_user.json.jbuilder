json.extract! user, :id, :name, :job_tittle, :last_tweet, :twitter_id, :created_at, :updated_at
json.url user_url(user, format: :json)
