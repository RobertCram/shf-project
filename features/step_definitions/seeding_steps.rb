
Given(/^There are no "([^"]*)" records in the db$/) do | models|
  model_klass = ActiveSupport::Inflector.singularize(models)
  eval "#{model_klass}.delete_all"
end

When(/^the system is seeded with initial data$/) do
  SHFProject::Application.load_tasks
  SHFProject::Application.load_seed
  Rake::Task['shf:load_regions'].reenable
  Rake::Task['shf:load_kommuns'].reenable
end

Then(/^(\d+) "([^"]*)" records should be created$/) do |number_of_records, models|
  model_klass = ActiveSupport::Inflector.singularize(models)
  expect((eval "#{model_klass}").all.size).to eq(number_of_records.to_i)
end
