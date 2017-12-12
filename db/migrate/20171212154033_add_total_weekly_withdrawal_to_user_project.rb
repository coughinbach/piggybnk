class AddTotalWeeklyWithdrawalToUserProject < ActiveRecord::Migration[5.1]
  def change
    add_monetize :user_projects, :total_weekly_withdrawal, currency: { present: false }
  end
end
