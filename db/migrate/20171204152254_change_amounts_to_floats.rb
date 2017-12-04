class ChangeAmountsToFloats < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :goal_amount, :float
    change_column :projects, :saved_total_amount, :float
  end
end
