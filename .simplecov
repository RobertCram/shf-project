require 'simplecov'
require 'coveralls'

SimpleCov.start 'rails' do

  # ignore everything included/covered by a filter:
  add_filter 'assets/'
  add_filter 'lib/tasks'
  add_filter '/bin/'
  add_filter 'docs/'
  add_filter 'features/'
  add_filter '/log/'
  add_filter 'script/'
  add_filter 'spec/'
  add_filter 'tmp'
  add_filter 'vcr_cassettes/'
  add_filter 'vendor/'


  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Views", "app/views"

  add_group "Helpers", "app/helpers"
  add_group "Mailers", "app/mailers"
  add_group "Policies", "app/policies"
  add_group "Services", "app/services"

  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end

end


SimpleCov.at_exit do
  SimpleCov.result.format!
end
