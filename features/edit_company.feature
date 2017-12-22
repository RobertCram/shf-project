Feature: As a member
  in order to easily update my information
  I need to be able to edit my company

  Background:
    Given the following users exists
      | email                   | admin | member |
      | paid_member@mutts.com   |       | true   |
      | unpaid_member@mutts.com |       | true   |
      | mere_user@mutts.com     |       | false  |
      | admin@shf.se            | true  | true   |

    Given the following payments exist
      | user_email            | start_date | expire_date | payment_type | status | hips_id |
      | paid_member@mutts.com | 2017-10-1  | 2017-12-31  | member_fee   | betald | none    |

    And the following companies exist:
      | name                  | company_number | email                  |
      | No More Snarky Barky  | 5560360793     | snarky@snarkybarky.com |
      | Bowsers               | 2120000142     | bowwow@bowsersy.com    |
      | Lapsed Member Company | 6613265393     | lapsed@company.com     |

    And the following applications exist:
      | user_email              | company_number | state    |
      | paid_member@mutts.com   | 5560360793     | accepted |
      | unpaid_member@mutts.com | 6613265393     | accepted |
      | mere_user@mutts.com     | 2120000142     | accepted |

  @time_adjust
  Scenario: Member can edit their company
    Given the date is set to "2017-10-01"
    Given I am logged in as "paid_member@mutts.com"
    And I am on the edit company page for "5560360793"
    Then I should see t("companies.edit.title", company_name: "No More Snarky Barky")

  Scenario: Unpaid member cannot edit their company
    Given I am logged in as "unpaid_member@mutts.com"
    And I am on the edit company page for "6613265393"
    Then I should not see t("companies.edit.title", company_name: "Lapsed Member Company")
    And I should see t("errors.not_permitted")

  Scenario: Prospective member can not edit their company
    Given I am logged in as "mere_user@mutts.com"
    And I am on the edit company page for "2120000142"
    Then I should not see t("companies.edit.title", company_name: "Bowsers")
    And I should see t("errors.not_permitted")

  Scenario: Visitor tries to edit a company
    Given I am Logged out
    And I am on the edit company page for "5560360793"
    Then I should see t("errors.not_permitted")

  Scenario: User can not edit someone else's company
    Given I am logged in as "mere_user@mutts.com"
    And I am on the edit company page for "5560360793"
    Then I should see t("errors.not_permitted")
