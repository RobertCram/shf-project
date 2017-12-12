Feature: As the owner of a company (or an admin)
  As I am on the company
  I should easily be able to edit it

  Background:

    Given the following users exists
      | email                 | admin | member    |
      | emma@happymutts.com   |       | true      |
      | lars@happymutts.com   |       | true      |
      | anna@happymutts.com   |       | true      |
      | bowser@snarkybarky.se |       | true      |
      | admin@shf.se          | true  | false     |

    Given the following companies exist:
      | name         | email                 | company_number |
      | happy mutts  | emma@happymutts.com   | 5562252998     |
      | snarky barky | bowser@snarkybarky.se | 2120000142     |

    And the following applications exist:
      | user_email            | company_number | state    |
      | emma@happymutts.com   | 5562252998     | accepted |
      | bowser@snarkybarky.se | 2120000142     | accepted |


  Scenario: Visitor does not see edit link for a company
    Given I am Logged out
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should not see t("companies.edit_company")

  Scenario: Admin does see edit link for company
    Given I am logged in as "admin@shf.se"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should see t("companies.edit_company")

  Scenario: Other user does not see edit link for a company
    Given I am logged in as "bowser@snarkybarky.se"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should not see t("companies.edit_company")

  Scenario: User related to company does see edit link for company
    Given I am logged in as "emma@happymutts.com"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should see t("companies.edit_company")
