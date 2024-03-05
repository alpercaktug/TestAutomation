# frozen_string_literal: true

chrome_driver_processes = `ps aux | grep chromedriver | grep -v grep`

if chrome_driver_processes.empty?
  puts 'No ChromeDriver processes found.'
else
  process_ids = chrome_driver_processes.split("\n").map { |line| line.split[1] }

  process_ids.each do |pid|
    `kill #{pid}`
    puts "Terminated ChromeDriver process with PID #{pid}."
  end
end
