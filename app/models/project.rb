class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  validates :name, presence: true, length: { in: 1..20 }
  validates :goal_amount_total_cents, presence: true, numericality: true
  validates :due_date, presence: true
  monetize :goal_amount_total_cents
  monetize :saved_amount_total_cents
end
