class CreateMembershipnumberSequence < ActiveRecord::Migration[5.1]

  def up

    first_membership_number = (ENV['SHF_FIRST_MEMBERSHIP_NUMBER'] || 100).to_i

    execute <<-SQL
      CREATE SEQUENCE membership_number_seq;
      SELECT setval('membership_number_seq', (SELECT COALESCE(MAX(CAST(membership_number AS INT))+1, #{first_membership_number}) FROM membership_applications), FALSE);
    SQL

  end

  def down

    execute <<-SQL
      DROP SEQUENCE membership_number_seq;
    SQL

  end

end
