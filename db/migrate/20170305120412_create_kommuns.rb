class CreateKommuns < ActiveRecord::Migration[5.1]
  def change
    create_table :kommuns do |t|
      t.string :name

      t.timestamps
    end
  end
end
