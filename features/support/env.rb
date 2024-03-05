# frozen_string_literal: true

require 'page-object'
require 'allure-cucumber'
require 'page-object/page_factory'
World(PageObject::PageFactory)

USER_NAME = ENV['BROWSERSTACK_USERNAME'] || 'alperaktu_pbH3hF'
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || 'BNXsGQxzoTtzjRoKLHwj'

BUILD_NAME = 'browserstack-demo'

BaseUrl = 'https://alperctest123.hotelrunner.com'

Before do
  puts "URL has set to : #{BaseUrl}"

  # connect_browserstack
  # run_local

  case ENV['PLATFORM']
  when 'local'
    run_local
  when 'browserstack'
    connect_browserstack
  else
    # raise "Unsupported platform: #{ENV['PLATFORM']}"
    run_local
  end
end

After do
  @browser.quit
end

def connect_browserstack
  caps = [{
            'browserName' => 'Chrome',
            'browserVersion' => 'latest',
            'os' => 'OS X',
            'osVersion' => 'Sonoma',
            'buildName' => BUILD_NAME,
            'sessionName' => 'Ruby thread 1',
            'debug' => 'true',
            'networkLogs' => 'true',
            'consoleLogs' => 'info'
          },
          {
            'browserName' => 'Safari',
            'browserVersion' => '15.6',
            'os' => 'OS X',
            'osVersion' => 'Monterey',
            'buildName' => BUILD_NAME,
            'sessionName' => 'Ruby thread 2'
          },
          {
            'browserName' => 'Chromium',
            'deviceOrientation' => 'portrait',
            'deviceName' => 'iPhone 13',
            'osVersion' => '15',
            'buildName' => BUILD_NAME,
            'sessionName' => 'Ruby thread 3'
          }]

  bstack_options = caps[0]

  options = Selenium::WebDriver::Options.send 'chrome'
  options.browser_name = bstack_options['browserName'].downcase
  options.add_option('bstack:options', bstack_options)
  @browser = Selenium::WebDriver.for(:remote, url: "https://#{USER_NAME}:#{ACCESS_KEY}@hub.browserstack.com/wd/hub",
                                              capabilities: options)
  @browser.manage.window.maximize
  @browser.manage.timeouts.implicit_wait = 10
end

def run_local
  options = Selenium::WebDriver::Chrome::Options.new
  # options.add_argument('--headless')
  # options.add_argument('--disable-gpu') # This is needed to run headless on certain systems

  @browser = Selenium::WebDriver.for :chrome, options: options
  @browser.manage.window.maximize
  # @browser.manage.timeouts.implicit_wait = 10

  #
  # @browser = Watir::Browser.new
  # @browser.window.maximize
end

AllureCucumber.configure do |config|
  config.results_directory = 'allure-report/allure-result'
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = 'prod'

  # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
  # config.link_tms_pattern = "http://www.jira.com/browse/{}"
  # config.link_issue_pattern = "http://www.jira.com/browse/{}"

  # additional metadata
  # environment.properties
  config.environment_properties = {
    custom_attribute: 'foo test run 11.37'
  }
  # categories.json
  # config.categories = File.new("my_custom_categories.json")
end
