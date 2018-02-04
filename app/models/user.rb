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

  def formatted_username
    group = groups.order(priority: :desc).limit(1).first
    format(group.name_format, username).html_safe
  end

  def self.current=(user)
    Thread.current[:user] = user if user.nil? || user.is_a?(User)
  end

  def self.current
    return Thread.current[:user] if Thread.current[:user].is_a?(User)

    @@guest ||= User.new(username: 'Guest')

    @@guest
  end

  def guest?
    username.casecmp('Guest').zero?
  end

  def logged_in?
    username.casecmp('Guest') != 0
  end

  def permission?(permission_name)
    permission = Permission.find_by(name: permission_name.to_s)
    raise "permission '#{permission_name}' was not found in database" unless permission

    return unless permission.value_type == 'boolean'
    groups.each do |group|
      group_permission = group.permission_to_groups.find_by(permission_id: permission.id)
      return true if group_permission && group_permission.value == 'true'
    end

    false
  end

  def board_permission?(board, permission_name)
    board_permission = BoardPermission.find_by(name: permission_name.to_s)
    raise "board permission '#{permission_name}' was not found in database" unless board_permission

    # user specific permissions
    user_permission = board_permission_to_targets.find_by(permission: board_permission, board: board)
    return user_permission.value if user_permission

    # group permissions
    group_permissions = board.board_permission_to_targets.where(permission: board_permission, group: groups)

    unless group_permissions.empty?
      group_permissions.each do |group|
        return true if group.value
      end

      return false
    end

    nil
  end

  private

  def set_default_group
    user_to_groups.create(group: Group.default_group)
  end

  def forbidden_names_validation
    errors.add(:username, "cannot be 'Guest'") if username.casecmp('guest').zero?
  end

  def invalidate_board_thread_relations
    BoardThread.where(user_id: id).update_all(user_id: nil, username: username, user_deleted: true)
  end
end
