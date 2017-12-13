class RenameMembershipApplication < ActiveRecord::Migration[5.1]
  def up
    rename_table :membership_applications, :shf_applications
    rename_table :business_categories_membership_applications, :business_categories_shf_applications

    rename_column :business_categories_shf_applications, :membership_application_id, :shf_application_id
    rename_column :uploaded_files, :membership_application_id, :shf_application_id
  end

  def down
    rename_column :uploaded_files, :shf_application_id, :membership_application_id
    rename_column :business_categories_shf_applications, :shf_application_id, :membership_application_id

    rename_table :business_categories_shf_applications, :business_categories_membership_applications
    rename_table :shf_applications, :membership_applications
  end
end
