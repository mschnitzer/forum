class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, confirmation: true
  validate :forbidden_names_validation

  has_secure_password

  has_many :user_to_groups, dependent: :destroy
  has_many :groups, through: :user_to_groups

  has_many :board_permission_to_targets, dependent: :destroy

  after_create :set_default_group
  after_destroy :invalidate_board_thread_relations

  @@guest = nil

  def self.current=(user)
    Thread.current[:user] = user if user.nil? || user.is_a?(User)
  end

  def self.current
    return Thread.current[:user] if Thread.current[:user].is_a?(User)

    unless @@guest
      @@guest = User.new(username: 'Guest')
    end

    @@guest
  end

  def guest?
    username.casecmp('Guest') == 0
  end

  def logged_in?
    username.casecmp('Guest') != 0
  end

  private

  def set_default_group
    user_to_groups.create(group: Group.default_group)
  end

  def forbidden_names_validation
    if username.casecmp('guest') == 0
      errors.add(:username, "cannot be 'Guest'")
    end
  end

  def invalidate_board_thread_relations
    BoardThread.where(user_id: id).update_all(user_id: nil, username: username, user_deleted: true)
  end
end
