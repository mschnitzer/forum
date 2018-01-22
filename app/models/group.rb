class Group < ApplicationRecord
  validates :name, presence: true

  has_many :user_to_groups
  has_many :users, through: :user_to_groups
end
