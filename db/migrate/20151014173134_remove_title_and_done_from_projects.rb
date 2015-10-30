class RemoveTitleAndDoneFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :title, :string
    remove_column :projects, :done, :boolean
  end
end
