class AddContactNameAndPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_name, :string
    add_column :users, :phone, :string
  end
end
