# frozen_string_literal: true

class BasePage

  def initialize(driver)
    @browser = driver
  end

  # Wait and click
  def click(by, value)
    element = wait_for_element(by, value)
    element.click
  end

  def get_text(by, value)
    element = wait_for_element(by, value)
    element.text
  end

  def wait_and_get_element(by, value)
    wait_for_element(by, value)
  end


  def wait_and_get_elements(by, value)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    elements = wait.until { @browser.find_elements(by, value) }

    unless elements.any?(&:displayed?)
      raise "No elements with #{by} '#{value}' are displayed within the specified timeout."
    end

    elements
  end


  def wait_for_element(by, value)
    wait = Selenium::WebDriver::Wait.new(timeout: 10, message: "Element not found within 10 seconds")

    begin
      element = wait.until { @browser.find_element(by, value) }
      unless element.displayed?
        puts "Element with #{by} '#{value}' was found, but not displayed."
      end
    rescue Selenium::WebDriver::Error::TimeOutError
      puts "Timeout error: Element with #{by} '#{value}' not found within the specified timeout."
      raise
    rescue StandardError => e
      puts "Error occurred: #{e.message}"
      raise
    end
    element
    end

end
