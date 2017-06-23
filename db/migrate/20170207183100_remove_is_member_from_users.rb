class RemoveIsMemberFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :is_member, :boolean
  end
end
