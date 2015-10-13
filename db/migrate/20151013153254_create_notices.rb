class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :title
      t.text :description
      
      t.timestamps null: false
    end
  end
end
