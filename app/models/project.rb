class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects
  validates :name, presence: true, length: { in: 1..20 }
  validates :goal_amount_total_cents, presence: true, numericality: true
  validates :due_date, presence: true
end
