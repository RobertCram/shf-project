class CreateMemberPages < ActiveRecord::Migration[5.1]
  def change
    create_table :member_pages do |t|
      t.string :filename, null: false
      t.string :title

      t.timestamps
    end
  end
end
