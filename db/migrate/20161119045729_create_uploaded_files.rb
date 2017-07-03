class CreateUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :uploaded_files do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
