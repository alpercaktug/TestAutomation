# frozen_string_literal: true

require 'rubygems'
require 'cucumber'
# require 'cucumber/rake/task'

task :run do
  tags = ENV['TAGS'] || '@smoke' # Use default tag if TAGS environment variable is not set
  platform = ENV['PLATFORM'] || 'browserstack'
  env = ENV['ENV'] || 'prod'

  puts "#{tags} tests started."
  puts "Test execution platform: #{platform}"
  puts "Environment: #{env}"

  sh "cucumber --tags #{tags}"
  #sh 'bundle exec allure serve allure-report/allure-result'
end
