Feature: Only members and admins can see members only (hidden) pages

  Background:

    Given the following users exists
      | email                    | admin | member    |
      | emma@happymutts.com      |       | true      |
      | not_a_member@bowsers.com |       | false     |
      | admin@shf.se             | true  | false     |

    Given the following payments exist
      | user_email          | start_date | expire_date | payment_type | status | hips_id |
      | emma@happymutts.com | 2017-10-1  | 2017-12-31  | member_fee   | betald | none    |

    And the following business categories exist
      | name  |
      | Rehab |

    And the following applications exist:
      | user_email          | company_number | categories | state    |
      | emma@happymutts.com | 5562252998     | Rehab      | accepted |


  Scenario: Visitor cannot see members only pages
    Given I am Logged out
    And I am on the static workgroups page
    Then I should see t("errors.not_permitted")
    And I should not see "Yrkesråd"

  Scenario: Visitor cannot see members only menu
    Given I am Logged out
    And I am on the "landing" page
    Then I should not see t("menus.nav.members.member_pages")

  Scenario: User cannot see members only pages
    Given I am logged in as "not_a_member@bowsers.com"
    And I am on the static workgroups page
    Then I should see t("errors.not_permitted")
    And I should not see "Yrkesråd"

  Scenario: User cannot see members only menu
    Given I am logged in as "not_a_member@bowsers.com"
    And I am on the "landing" page
    Then I should not see t("menus.nav.members.member_pages")

  @time_adjust
  Scenario: Member can see members only pages
    Given the date is set to "2017-10-01"
    Given I am logged in as "emma@happymutts.com"
    And  I am on the static workgroups page
    Then I should see "Yrkesrad"
    Then I should not see t("errors.not_permitted")

  @time_adjust
  Scenario: Member can see members only menu
    Given the date is set to "2017-10-01"
    Given I am logged in as "emma@happymutts.com"
    And I am on the "landing" page
    Then I should see t("menus.nav.members.member_pages")

  Scenario: Admin can see members only pages
    Given I am logged in as "admin@shf.se"
    And  I am on the static workgroups page
    Then I should see "Yrkesrad"
    Then I should not see t("errors.not_permitted")

  Scenario: Admin can see members only menu
    Given I am logged in as "admin@shf.se"
    And I am on the "landing" page
    Then I should see t("menus.nav.members.member_pages")
