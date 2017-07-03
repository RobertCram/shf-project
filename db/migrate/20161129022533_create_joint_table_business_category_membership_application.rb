class CreateJointTableBusinessCategoryMembershipApplication < ActiveRecord::Migration[5.1]
  def change
    create_table :business_categories_membership_applications do |t|
      t.belongs_to :membership_application, index: {name: 'index_on_applications'}
      t.belongs_to :business_category, index: {name: 'index_on_categories'}
    end
  end
end
