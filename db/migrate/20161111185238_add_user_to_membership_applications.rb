class AddUserToMembershipApplications < ActiveRecord::Migration[5.1]
  def change
    add_reference :membership_applications, :user, foreign_key: true
  end
end
