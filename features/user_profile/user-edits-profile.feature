Feature: As a registered user
  I want to be able to edit my profile
  Including my first name, last name, email and password

  Background:
    Given the following users exists
      | email             | password | admin | member    | first_name | last_name |
      | admin@random.com  | password | true  | false     | emma       | admin     |
      | member@random.com | password | false | true      | mary       | member    |
      | user@random.com   | password | false | false     | ulysses    | user      |

    And the following applications exist:
      | user_email        | company_number | state    |
      | member@random.com | 5560360793     | accepted |

  Scenario: Admin edits profile
    Given I am on the "landing" page
    When I click on t("devise.sessions.new.log_in") link
    Then I should be on "login" page
    And I fill in t("activerecord.attributes.user.email") with "admin@random.com"
    And I fill in t("activerecord.attributes.user.password") with "password"
    And I click on t("devise.sessions.new.log_in") button
    And I should see t("hello", name: 'emma')
    Then I click on the t("devise.registrations.edit.title") link
    And I fill in t("activerecord.attributes.user.first_name") with "NewEmma"
    And I fill in t("activerecord.attributes.user.last_name") with "NewAdmin"
    And I fill in t("devise.registrations.edit.current_password") with "password"
    And I click on t("devise.registrations.edit.submit_button_label") button
    And I should see t("hello", name: 'NewEmma')
    Then I click on the t("devise.registrations.edit.title") link
    And the t("activerecord.attributes.user.last_name") field should be set to "NewAdmin"
    And I fill in t("activerecord.attributes.user.password") with "NewPassword"
    And I fill in t("devise.registrations.edit.confirm_password") with "password"
    And I fill in t("devise.registrations.edit.current_password") with "password"
    And I click on t("devise.registrations.edit.submit_button_label") button
    And I should see t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
    Then I fill in t("activerecord.attributes.user.password") with "NewPassword"
    And I fill in t("devise.registrations.edit.confirm_password") with "NewPassword"
    And I fill in t("devise.registrations.edit.current_password") with "password"
    And I click on t("devise.registrations.edit.submit_button_label") button
    Then I should see t("devise.registrations.edit.success")

  Scenario: Member edits profile
    Given I am on the "landing" page
    When I click on t("devise.sessions.new.log_in") link
    Then I should be on "login" page
    And I fill in t("activerecord.attributes.user.email") with "member@random.com"
    And I fill in t("activerecord.attributes.user.password") with "password"
    And I click on t("devise.sessions.new.log_in") button
    And I should see t("hello", name: 'mary')
    Then I click on the t("devise.registrations.edit.title") link
    And I fill in t("activerecord.attributes.user.first_name") with "NewMary"
    And I fill in t("devise.registrations.edit.current_password") with "password"
    And I click on t("devise.registrations.edit.submit_button_label") button
    And I should see t("hello", name: 'NewMary')

  Scenario: User edits profile
    Given I am on the "landing" page
    When I click on t("devise.sessions.new.log_in") link
    Then I should be on "login" page
    And I fill in t("activerecord.attributes.user.email") with "user@random.com"
    And I fill in t("activerecord.attributes.user.password") with "password"
    And I click on t("devise.sessions.new.log_in") button
    And I should see t("hello", name: 'ulysses')
    Then I click on the t("devise.registrations.edit.title") link
    And I fill in t("activerecord.attributes.user.first_name") with "NewUlysses"
    And I fill in t("devise.registrations.edit.current_password") with "password"
    And I click on t("devise.registrations.edit.submit_button_label") button
    And I should see t("hello", name: 'NewUlysses')
