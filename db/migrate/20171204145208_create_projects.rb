class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :status, default: "Active"
      t.integer :goal_amount
      t.integer :saved_total_amount
      t.date :due_date

      t.timestamps
    end
  end
end
