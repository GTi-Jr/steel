class AddNameAndCompletedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :name, :string
    add_column :projects, :completed, :boolean, default: false
  end
end
