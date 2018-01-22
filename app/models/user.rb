class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

  has_many :user_to_groups
  has_many :groups, through: :user_to_groups
end
