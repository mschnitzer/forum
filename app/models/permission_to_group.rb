class PermissionToGroup < ApplicationRecord
  validates :value, presence: true

  belongs_to :permission
  belongs_to :group
end
