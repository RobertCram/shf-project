Given(/^I am on the "([^"]*)" page(?: for "([^"]*)")?$/) do |page, email|
  user = email == nil ? @user :  User.find_by(email: email)
  case page.downcase
    when 'landing'
      path = root_path
    when 'login'
      path = new_user_session_path
    when 'edit my application'
      user.membership_applications.reload
      path = edit_membership_application_path(user.membership_application)
    when 'business categories'
      path = business_categories_path
    when 'membership applications'
      path = membership_applications_path
    when 'all companies'
      path = companies_path
    when 'create a new company'
      path = new_company_path
    when 'submit new membership application'
      path = new_membership_application_path
    when 'edit my company'
      path = edit_company_path(user.membership_application.company)
    when 'user instructions'
      path = information_path
    when 'member instructions'
      path = information_path
    when 'new password'
      path = new_user_password_path
    when 'register as a new user'
      path = new_user_registration_path
    when 'edit registration for a user'
      path = edit_user_registration_path
    when 'all users'
      path = users_path
    when 'all shf documents'
      path = shf_documents_path
    when 'new shf document'
      path = new_shf_document_path
    when 'all waiting for info reasons'
      path = admin_only_member_app_waiting_reasons_path
    when 'new waiting for info reason'
      path = new_admin_only_member_app_waiting_reason_path
    when 'application', 'show application'
      path = membership_application_path(user.membership_application)
    when 'user details'
      path = user_path(user)
    else
      fail("no path defined for \"#{page}\"")
  end
  visit path_with_locale(path)
end


When(/^I fail to visit the "([^"]*)" page$/) do |page|
  case page.downcase
    when 'applications index'
      path = membership_applications_path
    else
      path = 'path not set'
  end
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
