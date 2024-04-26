# frozen_string_literal: true

require 'page-object'
require 'allure-cucumber'
require 'page-object/page_factory'
require 'logger'
require 'json'
require 'yaml'

World(PageObject::PageFactory)

@browserstack_config = YAML.load_file('config/browserstack.yml')

USER_NAME = ENV['BROWSERSTACK_USERNAME'] || @browserstack_config['userName']
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || @browserstack_config['accessKey']
ENVIRONMENT = ENV['ENV'] || 'prod'

Before do |scenario|
  @current_scenario_name = scenario.name

  setup_env
  setup_browser

  puts "URL has been set to: #{$BaseUrl}"
  puts "Running Scenario: #{@current_scenario_name}"
end

After do |scenario|
  if scenario.failed?
    puts "Scenario '#{scenario.name}' failed!"
    @browser.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed"}}')
    # You can add additional actions for failed scenarios here, like taking a screenshot
    # Example: driver.save_screenshot("failed_scenario.png")
  else
    puts "Scenario '#{scenario.name}' passed!"
    @browser.execute_script('browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed"}}')
  end
  # Quit the WebDriver session
  @browser.quit
end


def setup_env
  @env_config = YAML.load_file('config/env.yml')

  $BaseUrl = @env_config[ENVIRONMENT][0]['base_url']
  puts $BaseUrl
end

def setup_browser
  if ENV['PLATFORM'] == 'local'
    run_local
  else
    connect_browserstack
  end
end

def connect_browserstack
  @browserstack_config = YAML.load_file('config/browserstack.yml')

  if @browserstack_config['platforms'].nil? || @browserstack_config['platforms'].empty?
    puts 'No platform configuration found in browserstack.yml'
    return
  end

  cap = @browserstack_config['platforms'][0] # Select platform in the configuration

  options = Selenium::WebDriver::Options.send cap['browserName'].downcase

  cap['buildName'] =  ENV['BROWSERSTACK_BUILD_NAME']
  cap['sessionName'] = "#{@current_scenario_name}"
  cap['local'] = true if ENVIRONMENT == 'staging'

  options.add_option('bstack:options', cap)

  @browser = Selenium::WebDriver.for(:remote, url: "https://#{USER_NAME}:#{ACCESS_KEY}@hub.browserstack.com/wd/hub",
                                     capabilities: options)
  response = @browser.execute_script('browserstack_executor: {"action": "getSessionDetails"}')

  parsed_response = JSON.parse(response)

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
end

AllureCucumber.configure do |config|
  config.environment = ENV['ENV'] || 'prod'
  config.results_directory = 'allure-result'
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)

  # environment.properties
  config.environment_properties = {
    custom_attribute: 'foo'
  }
end
