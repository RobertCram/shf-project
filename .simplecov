require 'simplecov'
require 'coveralls'

SimpleCov.start 'rails' do
   add_filter 'lib/tasks'
end

SimpleCov.at_exit do
  SimpleCov.result.format!
end
