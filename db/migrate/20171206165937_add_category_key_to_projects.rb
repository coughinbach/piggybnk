class AddCategoryKeyToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :category, index: true, foreign_key: true
  end
end
