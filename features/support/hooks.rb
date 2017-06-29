Before('@javascript, @poltergeist') do
  Capybara.current_driver = :poltergeist
end

After('@javascript, @poltergeist') do
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script('window.jQuery ? 0 : jQuery.active').zero?
  end
  Capybara.reset_sessions!
  Capybara.current_driver = :rack_test
end
