class BoardPermissionToTarget < ApplicationRecord
  belongs_to :permission, class_name: 'BoardPermission'
  belongs_to :board
  belongs_to :user
  belongs_to :group
end
