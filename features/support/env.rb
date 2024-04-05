require 'page-object'
require 'allure-cucumber'
require 'page-object/page_factory'
require 'logger'
require 'json'
require 'yaml'

World(PageObject::PageFactory)

USER_NAME = ENV['BROWSERSTACK_USERNAME'] || 'alperctest_V0HSlO'
ACCESS_KEY = ENV['BROWSERSTACK_ACCESS_KEY'] || 'EG1QJWQGruPKrykyaGyS'

$BaseUrl = ENV['BASE_URL'] || 'https://testautomation.hotelrunner.com'

Before do |scenario|
  @current_scenario_name = scenario.name

  puts "URL has been set to: #{$BaseUrl}"
  puts "Running Scenario: #{@current_scenario_name}"

  setup_env
  setup_browser
end

After do
  @browser.quit
end

def setup_env
  $BaseUrl = if ENV['ENV'] == 'staging'
    'https:/testautomation-staging.hotelrunner.com'
  else
    'https://testautomation.hotelrunner.com'
             end
end

def setup_browser
  if ENV['PLATFORM'] == 'browserstack'
    connect_browserstack
  else
    connect_browserstack
  end
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
            'consoleLogs' => 'info',
            'local' => @local_parameter.to_s
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
