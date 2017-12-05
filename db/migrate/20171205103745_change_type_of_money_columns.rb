class ChangeTypeOfMoneyColumns < ActiveRecord::Migration[5.1]
  def change
    add_monetize :projects, :goal_amount_total, currency: { present: false }
    add_monetize :projects, :saved_amount_total, currency: { present: false }
    add_monetize :user_projects, :withdrawal_amount_total, currency: { present: false }
    add_monetize :user_projects, :saved_amount_solo, currency: { present: false }
  end
end
