require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end

task :run do
  tags = ENV['TAGS'] || '@smoke'  # Use default tag if TAGS environment variable is not set
  platform = ENV['PLATFORM'] || 'local'

  puts "Tests run on: #{platform}"

  sh "cucumber --tags #{tags}"
  sh "bundle exec allure serve report/allure-results"

end
