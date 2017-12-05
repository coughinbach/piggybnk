class RenameAdminToProjectAdminInUserProject < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_projects, :admin, :project_admin
  end
end
