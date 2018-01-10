class AddAttachmentPhotoToUsers < ActiveRecord::Migration[5.1]
  def self.up
    add_attachment :users, :member_photo
  end

  def self.down
    remove_attachment :users, :member_photo
  end
end
