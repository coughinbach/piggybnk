class AddCreditCardToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :credit_card, :json
  end
end
