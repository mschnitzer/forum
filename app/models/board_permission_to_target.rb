class BoardPermissionToTarget < ApplicationRecord
  belongs_to :permission, class_name: 'BoardPermission'
  belongs_to :board
  belongs_to :user, optional: true
  belongs_to :group, optional: true

  validate :user_or_group_validation

  private

  def user_or_group_validation
    errors.add(:base, 'User or Group must be set') unless user || group
    errors.add(:base, 'either User or Group can be set') if user && group
  end
end
