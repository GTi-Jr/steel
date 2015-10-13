class AddIndexesToUserNoticePhotoDocument < ActiveRecord::Migration
  def change
    add_column :documents, :notice_id, :integer
    add_index :documents, :notice_id

    add_column :photos, :notice_id, :integer
    add_index :photos, :notice_id

    add_column :notices, :project_id, :integer
    add_index :notices, :project_id


  end
end
