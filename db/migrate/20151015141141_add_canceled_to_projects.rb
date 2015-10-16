class AddCanceledToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :canceled, :boolean, default: false
  end
end
