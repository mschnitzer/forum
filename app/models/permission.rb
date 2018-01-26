class Permission < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :value_type, presence: true
  validates :default_value, presence: true

  belongs_to :category, class_name: 'PermissionCategory'
  has_many :permission_to_groups
  has_many :groups, through: :permission_to_groups

  enum value_type: { integer: 1, boolean: 2, text: 3 }
end
