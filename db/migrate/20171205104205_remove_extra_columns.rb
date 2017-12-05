class RemoveExtraColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :goal_amount
    remove_column :projects, :saved_total_amount
    remove_column :user_projects, :saved_amout_indiv
    remove_column :user_projects, :withdrawal_amount
  end
end
