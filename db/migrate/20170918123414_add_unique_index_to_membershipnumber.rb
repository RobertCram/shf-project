class AddUniqueIndexToMembershipnumber < ActiveRecord::Migration[5.1]

  def up
    add_index :membership_applications, :membership_number, unique: true
  end

  def down
    remove_index :membership_applications, :membership_number, unique: true
  end

end
