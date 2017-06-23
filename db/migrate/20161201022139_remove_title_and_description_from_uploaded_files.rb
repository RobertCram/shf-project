class RemoveTitleAndDescriptionFromUploadedFiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :uploaded_files, :title, :string, null: true, default: '', index: true
    remove_column :uploaded_files, :description, :string, null: true, default: '', index: false
  end
end
