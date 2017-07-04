class MoveFirstnameAndLastnameToUser < ActiveRecord::Migration[5.1]
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    execute "UPDATE users u SET first_name = ma.first_name FROM membership_applications ma WHERE u.id = ma.user_id;"
    execute "UPDATE users u SET last_name = ma.last_name FROM membership_applications ma WHERE u.id = ma.user_id;"
    remove_column :membership_applications, :first_name
    remove_column :membership_applications, :last_name
  end

  def self.down
    add_column :membership_applications, :first_name, :string
    add_column :membership_applications, :last_name, :string
    execute "UPDATE membership_applications ma SET first_name = u.first_name FROM users u WHERE ma.user_id = u.id;"
    execute "UPDATE membership_applications ma SET last_name = u.last_name FROM users u WHERE ma.user_id = u.id;"
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
