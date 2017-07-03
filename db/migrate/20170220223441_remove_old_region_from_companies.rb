class RemoveOldRegionFromCompanies < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :old_region, :string
  end
end
