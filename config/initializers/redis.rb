$redis = Redis.new(url: ENV["REDIS_URL"]) if Rails.new.production?
