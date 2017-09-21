class CreateMembershipnumberSequence < ActiveRecord::Migration[5.1]

  def up

    execute <<-SQL
      CREATE SEQUENCE membership_number_seq;
      SELECT setval('membership_number_seq', (SELECT COALESCE(MAX(CAST(membership_number AS INT)), 1) FROM membership_applications));
    SQL

  end

  def down

    execute <<-SQL
      DROP SEQUENCE membership_number_seq;
    SQL

  end

end
