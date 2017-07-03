class ChangeMembershipApplication < ActiveRecord::Migration[5.1]
  def change
    change_table :membership_applications do |t|
      t.remove :company_name, :contact_person, :company_email
      t.string :first_name, :last_name, :contact_email
    end
  end
end