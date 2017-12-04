class Project < ApplicationRecord
  has_many :user_projects
  has_many :users, through: :user_projects
  validates :name, presence: true, length: { in: 3..60 }
  validates :goal_amount, presence: true, numericality: true
  validates :due_date, presence: true
end
