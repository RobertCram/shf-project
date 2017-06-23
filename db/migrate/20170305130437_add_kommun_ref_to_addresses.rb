class AddKommunRefToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :kommun, foreign_key: true
    remove_column :addresses, :kommun, :string
  end
end
