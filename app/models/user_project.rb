class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  monetize :withdrawal_amount_total_cents
  monetize :saved_amount_solo_cents
end
