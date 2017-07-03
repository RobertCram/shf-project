class AddStateToMembershipApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :membership_applications, :state, :string, default: 'new'
  end
end
