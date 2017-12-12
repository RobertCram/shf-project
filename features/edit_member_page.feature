Feature: Edit a member page

  As an admin
  I want to be able to maintain content in a member page

  Background:

    Given the following users exists
      | email                    | admin |
      | admin@shf.se             | true  |

  Scenario: Admin can edit contents of member page
    Given I am logged in as "admin@shf.se"
    And I am on the test member page
    And I click on t("shf_documents.contents_show.edit_member_page")
    And I fill in "contents" with "This is content in the member pages test file."
    And I click on t("submit")
    And I should see "This is content in the member pages test file."

  Scenario: Admin can edit title of member page
    Given I am logged in as "admin@shf.se"
    And I am on the test member page
    And I should see "Testfile"
    And I click on t("shf_documents.contents_show.edit_member_page")
    And I fill in "title" with "New Title for Member Page"
    And I click on t("submit")
    And I should see "New Title for Member Page"
    And I should not see "Testfile"
