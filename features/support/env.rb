require 'page-object'
require "allure-cucumber"


USER_NAME = ENV['BROWSERSTACK_USERNAME'] || "alperaktu_pbH3hF"
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || "BNXsGQxzoTtzjRoKLHwj"

BUILD_NAME = "browserstack-demo"


Before do
  BaseUrl = "https://alperctest123.hotelrunner.com"
  puts "URL has set to : " + BaseUrl

  #connect_browserstack
  #run_local

  case ENV['PLATFORM']
  when 'local'
    run_local
  when 'browserstack'
    connect_browserstack
  else
    #raise "Unsupported platform: #{ENV['PLATFORM']}"
    run_local
  end
end

After do
  @browser.quit
end

def connect_browserstack
  caps = [{
            "browserName" => "Chrome",
            "browserVersion" => "latest",
            "os" => "OS X",
            "osVersion" => "Sonoma",
            "buildName" => BUILD_NAME,
            "sessionName" => "Ruby thread 1",
            "debug" => "true",
            "networkLogs" => "true",
            "consoleLogs" => "info"
          },
          {
            "browserName" => "Safari",
            "browserVersion" => "15.6",
            "os" => "OS X",
            "osVersion" => "Monterey",
            "buildName" => BUILD_NAME,
            "sessionName" => "Ruby thread 2"
          },
          {
            "browserName" => "Chromium",
            "deviceOrientation" => "portrait",
            "deviceName" => "iPhone 13",
            "osVersion" => "15",
            "buildName" => BUILD_NAME,
            "sessionName" => "Ruby thread 3"
          }]

  bstack_options = caps[0]

  options = Selenium::WebDriver::Options.send "chrome"
  options.browser_name = bstack_options["browserName"].downcase
  options.add_option('bstack:options', bstack_options)
  @browser = Selenium::WebDriver.for(:remote, :url => "https://#{USER_NAME}:#{ACCESS_KEY}@hub.browserstack.com/wd/hub",
                                     :capabilities => options)
  @browser.manage.window.maximize
end

def run_local
  @browser = Selenium::WebDriver.for :chrome
  @browser.manage.window.maximize
end


AllureCucumber.configure do |config|
  config.results_directory = "allure-report/data/test-cases"
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = "prod"

  # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
  #config.link_tms_pattern = "http://www.jira.com/browse/{}"
  #config.link_issue_pattern = "http://www.jira.com/browse/{}"

  # additional metadata
  # environment.properties
  config.environment_properties = {
    custom_attribute: "foo test run cucumber"
  }
  # categories.json
  #config.categories = File.new("my_custom_categories.json")
end

