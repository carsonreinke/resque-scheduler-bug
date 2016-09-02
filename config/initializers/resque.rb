require 'resque'
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file(File.join rails_root, '/config/resque.yml')
Resque.redis = resque_config[rails_env]
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
Resque.inline = Rails.env.test?
Resque.redis.namespace = "resque-scheduler-bug:#{Rails.env}"

schedule = {}
schedule["test_job"] = {
  description: "test job that should appear",
  every: ["30s", {first_in: "0m"} ],
  class: "TestJob",
  queue: "basic",
  args: [
    "hello world"
  ]
}
Resque.schedule = ActiveScheduler::ResqueWrapper.wrap schedule

require 'resque-scheduler'
require 'resque/scheduler/server'