class CreateJoinTableBusinessCategoryCompany < ActiveRecord::Migration[5.1]
  def change
    create_table :business_categories_companies do |t|
      t.belongs_to :company, index: {name: 'index_on_companies'}
      t.belongs_to :business_category, index: {name: 'index_on_co_categories'}
    end
  end
end
