class Group < ApplicationRecord
  validates :name, presence: true
  validate :name_format_validation

  has_many :user_to_groups, dependent: :destroy
  has_many :users, through: :user_to_groups
  has_many :permission_to_groups
  has_many :permissions, through: :permission_to_groups
  has_many :board_permission_to_targets, dependent: :destroy

  scope :default_group, -> { find_by(default_group: true) }

  private

  def name_format_validation
    errors.add(:name_format, 'must contain %s') unless name_format && name_format.index('%s')
  end
end
