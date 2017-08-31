Given(/^I am on the "([^"]*)" page(?: for "([^"]*)")?$/) do |page, email|
  user = email == nil ? @user :  User.find_by(email: email)
  visit path_with_locale(get_path(page, user))
end


When(/^I fail to visit the "([^"]*)" page$/) do |page|
  path = get_path(page)
  visit path_with_locale(path)
  expect(current_path).not_to be path
end


When(/^I am on the static workgroups page$/) do
  visit page_path('yrkesrad')
end


When(/^I am on the test member page$/) do
  path = File.join(Rails.root, 'spec', 'fixtures',
                   'member_pages', 'testfile.html')

  allow_any_instance_of(ShfDocumentsController).to receive(:page_and_file_path)
    .and_return([ 'testfile', path ])

  visit contents_show_path('testfile')
end
