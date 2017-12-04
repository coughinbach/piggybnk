class CreateUserProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_projects do |t|
      t.float :withdrawal_amount
      t.float :saved_amout_indiv
      t.boolean :admin, default: false
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
