class CreateAddresses < ActiveRecord::Migration[5.1]

  def up

    create_table :addresses do |t|
      t.string :street_address
      t.string :post_code
      t.string :kommun
      t.string :city
      t.string :country, default: 'Sveriges', null: false

      t.references :region, foreign_key: true

      t.references :addressable, polymorphic: true, index: true
    end

    # take the data out of the companies table and put it into the addresses table
    execute <<-SQL
      INSERT INTO addresses (street_address, post_code, city, region_id, addressable_id) SELECT companies.street, companies.post_code, companies.city, companies.region_id, companies.id FROM companies;
    SQL

    execute <<-SQL
      UPDATE addresses SET addressable_type='Company'
    SQL

    remove_column :companies, :street
    remove_column :companies, :post_code
    remove_column :companies, :city
    remove_foreign_key :companies, column: :region_id
    remove_column :companies, :region_id

  end


  def down

    add_column  :companies, :street, :string
    add_column  :companies, :post_code, :string
    add_column  :companies, :city, :string
    add_reference :companies, :region, foreign_key: true, index: true

    execute <<-SQL
      UPDATE companies
        SET  street = addresses.street_address, city = addresses.city, post_code = addresses.post_code, region_id = addresses.region_id
      FROM addresses
      WHERE addresses.addressable_id = companies.id
    SQL

    drop_table :addresses

  end

end
