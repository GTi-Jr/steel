class AddIndexesToUserNoticePhotoDocument < ActiveRecord::Migration
  def change
    add_column :documents, :notice_id, :integer
    add_index :documents, :notice_id

    add_column :photos, :notice_id, :integer
    add_index :photos, :notice_id

    add_column :notices, :user_id, :integer
    add_index :notices, :user_id
  end
end
