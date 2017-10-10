class MoveMembershipnumberToUser < ActiveRecord::Migration[5.1]
  def change
    reversible do |direction|

      direction.up do
        add_column :users, :membership_number, :string
        add_index :users, :membership_number, unique: true
        execute "UPDATE users u SET membership_number = ma.membership_number FROM membership_applications ma WHERE u.id = ma.user_id;"
        remove_column :membership_applications, :membership_number
      end

      direction.down do
        add_column :membership_applications, :membership_number, :string
        execute "UPDATE membership_applications ma SET membership_number = u.membership_number FROM users u WHERE ma.user_id = u.id;"
        remove_column :users, :membership_number
      end

    end
  end
end
