class RenamePhotosToAttachments < ActiveRecord::Migration
  def self.up
    rename_table :photos, :attachments

  end

  def self.down
    rename_table :attachments, :photos
  end
end
