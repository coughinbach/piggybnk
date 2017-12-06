class AddSoloGoalToUserProject < ActiveRecord::Migration[5.1]
  def change
    add_monetize :user_projects, :goal_amount_solo, currency: { present: false }
  end
end
