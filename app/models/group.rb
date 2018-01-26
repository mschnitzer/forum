class Group < ApplicationRecord
  validates :name, presence: true

  has_many :user_to_groups, dependent: :destroy
  has_many :users, through: :user_to_groups
  has_many :permission_to_groups
  has_many :permissions, through: :permission_to_groups

  scope :default_group, -> { find_by(default_group: true) }
end
