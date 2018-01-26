class BoardPermission < ApplicationRecord
  validates :name, presence: true

  has_many :board_permission_to_targets, foreign_key: :permission_id
  has_many :users, through: :board_permission_to_targets
  has_many :groups, through: :board_permission_to_targets
end
