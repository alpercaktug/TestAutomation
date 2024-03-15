# frozen_string_literal: true

class ScenarioContext
  attr_accessor :data

  def initialize
    @data = {}
  end
end

# Set up the context object for each scenario
Before do
  @context = ScenarioContext.new
  puts 'ScenarioContext initialized'
end