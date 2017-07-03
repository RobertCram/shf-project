class AddAttachmentActualFileToUploadedFiles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :uploaded_files do |t|
      t.attachment :actual_file
    end
  end

  def self.down
    remove_attachment :uploaded_files, :actual_file
  end
end
