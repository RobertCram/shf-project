class ChangeStateDefaultInMembershipApplication < ActiveRecord::Migration[5.1]
  def change

    change_column_default :membership_applications, :state, from: 'Pending', to: 'new'

    # MembershipApplication.where(state: 'Pending').find_each do |pending_app|
    #   pending_app.state = 'new'
    #   pending_app.save
    # end
  end
end
