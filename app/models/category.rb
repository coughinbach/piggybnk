class Category < ApplicationRecord
  has_many :projects
  mount_uploader :photo, PhotoUploader
end
