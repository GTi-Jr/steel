class AddNameAndDoneToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :title, :string
    add_column :projects, :done, :boolean
  end
end
