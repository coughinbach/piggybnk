class RemoveCreditCardFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :credit_card
  end
end
