class AddExtraWithdrawalToUserProject < ActiveRecord::Migration[5.1]
  def change
    add_monetize :user_projects, :extra_withdrawal, currency: { present: false }
  end
end
