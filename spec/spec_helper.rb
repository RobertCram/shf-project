require 'simplecov'
# ^^ https://github.com/colszowka/simplecov#using-simplecov-for-centralized-config

require 'pundit/rspec'
require 'paperclip/matchers'

# Coveralls.wear_merged!('rails')

# CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Paperclip::Shoulda::Matchers

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_paperclip_files/"]) if Object.const_defined?('Rails')
  end
end
