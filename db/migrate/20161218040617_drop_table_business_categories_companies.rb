class DropTableBusinessCategoriesCompanies < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :business_categories, :companies
  end
end
