class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :user_to_groups
  has_many :groups, through: :user_to_groups

  after_create :set_default_group

  private

  def set_default_group
    user_to_groups.create(group: Group.default_group)
  end
end
