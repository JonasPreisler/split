Split.configure do |config|
  config.db_failover = true # handle Redis errors gracefully
  config.db_failover_on_db_error = -> (error) { Rails.logger.error(error.message) }
  config.allow_multiple_experiments = true
  config.enabled = true
  config.persistence = Split::Persistence::SessionAdapter
  #config.start_manually = false ## new test will have to be started manually from the admin panel. default false
  #config.reset_manually = false ## if true, it never resets the experiment data, even if the configuration changes
  config.include_rails_helper = true
end
Split::Dashboard.use Rack::Auth::Basic do |username, password|
	username == 'admin' && password == "hej"
end

if ENV["REDISTOGO_URL"]
   uri = URI.parse(ENV["REDISTOGO_URL"])
   namespace = ["split", "myapp", Rails.env].join(":")

   redis = Redis.new(host: uri.host,
                     port: uri.port,
                     password: uri.password,
                     thread_safe: true
                    )

   redis_namespace = Redis::Namespace.new(namespace, redis: redis)

   Split.redis = redis_namespace
end