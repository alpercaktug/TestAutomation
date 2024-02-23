require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'


task :run do
  tags = ENV['TAGS'] || '@smoke'  # Use default tag if TAGS environment variable is not set
  platform = ENV['PLATFORM'] || 'local'

  puts "Tests run on: #{platform}"

  sh "cucumber --tags #{tags}"
  #sh "bundle exec allure serve allure-report/data/test-cases"
end
