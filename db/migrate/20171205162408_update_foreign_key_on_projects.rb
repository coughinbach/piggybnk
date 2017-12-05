class UpdateForeignKeyOnProjects < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :user_projects, :projects
    add_foreign_key :user_projects, :projects, on_delete: :cascade
  end
end
