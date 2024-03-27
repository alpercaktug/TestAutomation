# frozen_string_literal: true

require 'page-object'
require 'allure-cucumber'
require 'page-object/page_factory'
require 'logger'
require 'json'


World(PageObject::PageFactory)

USER_NAME = ENV['BROWSERSTACK_USERNAME'] || 'alperctest_Ug4qG2'
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || 'eyEAqzbsNpYEX2sHhUGH'

BaseUrl = 'https://testautomation.hotelrunner.com'

Before do |scenario|
  @current_scenario_name = scenario.name
  puts "URL has set to : #{BaseUrl}"
  puts "Running Scenario: #{@current_scenario_name}"

  case ENV['PLATFORM']
  when 'local'
    run_local
  when 'browserstack'
    connect_browserstack
  else
    # raise "Unsupported platform: #{ENV['PLATFORM']}"
    connect_browserstack
  end
end

After do
  @browser.quit
end

After('@cancel') do
  step 'Cancel reservation on result page'
  step 'I should see the reservation is "Canceled"'
  puts 'Reservation canceled'
end

def connect_browserstack
  caps = [{
    'browserName' => 'Chrome',
    'browserVersion' => 'latest',
    'os' => 'OS X',
    'osVersion' => 'Sonoma',
    'buildName' => "#{Time.now.strftime('%d-%m-%Y')}-tests",
    'sessionName' => "#{@current_scenario_name} -- Chrome",
    'debug' => 'true',
    'networkLogs' => 'true',
    'consoleLogs' => 'info'
  }, {
    'browserName' => 'Safari',
    'browserVersion' => '15.6',
    'os' => 'OS X',
    'osVersion' => 'Monterey',
    'buildName' => "#{Time.now.strftime('%d-%m-%Y')}-tests",
    'sessionName' => "#{@current_scenario_name} -- Safari",
    'debug' => 'true',
    'networkLogs' => 'true',
    'consoleLogs' => 'info'
  }, {
    'browserName' => 'firefox',
    'browserVersion' => 'latest-beta',
    'os' => 'Windows',
    'osVersion' => '10',
    'buildName' => "#{Time.now.strftime('%d-%m-%Y')}-tests",
    'sessionName' => "#{@current_scenario_name} -- firefox",
    'debug' => 'true',
    'networkLogs' => 'true',
    'consoleLogs' => 'info'
  }]


  bstack_options = caps[0]

  options = Selenium::WebDriver::Options.send 'chrome'
  options.browser_name = bstack_options['browserName'].downcase
  options.add_option('bstack:options', bstack_options)
  @browser = Selenium::WebDriver.for(:remote, url: "https://#{USER_NAME}:#{ACCESS_KEY}@hub.browserstack.com/wd/hub",
                                              capabilities: options)
  #@browserstack_session_url = @browser.session_id
  response = @browser.execute_script('browserstack_executor: {"action": "getSessionDetails"}')
  #puts response

  parsed_response = JSON.parse(response)

  # Get the value of 'public_url'
  public_url = parsed_response['public_url']

  puts "Public URL: #{public_url}"

  Allure.add_link(name: 'BrowserStack Session', url: public_url)


  @browser.manage.window.maximize
  @browser.manage.timeouts.implicit_wait = 10
end

def run_local
  options = Selenium::WebDriver::Chrome::Options.new

  @browser = Selenium::WebDriver.for :chrome, options: options
  @browser.manage.window.maximize
  # @browser.manage.timeouts.implicit_wait = 10
end

AllureCucumber.configure do |config|
  config.results_directory = 'allure-result'
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
    custom_attribute: 'foo test'
  }
  # categories.json
  # config.categories = File.new("my_custom_categories.json")
end
