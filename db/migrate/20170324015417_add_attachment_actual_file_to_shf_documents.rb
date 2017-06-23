class AddAttachmentActualFileToShfDocuments < ActiveRecord::Migration[5.1]

  def self.up
    change_table :shf_documents do |t|
      t.attachment :actual_file
    end
  end

  def self.down
    remove_attachment :shf_documents, :actual_file
  end
end
