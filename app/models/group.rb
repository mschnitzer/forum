class Group < ApplicationRecord
  validates :name, presence: true

  has_many :user_to_groups, dependent: :destroy
  has_many :users, through: :user_to_groups
  has_many :permission_to_groups
  has_many :permissions, through: :permission_to_groups
  has_many :board_permission_to_targets, dependent: :destroy

  scope :default_group, -> { find_by(default_group: true) }
end
