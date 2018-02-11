class BoardThreadPostPolicy < ApplicationPolicy
  def show?
    # deny access if user doesn't have access to the post's thread
    return false unless Pundit.policy(user, record.thread).show?

    if record.disabled
      # prefer board specific permissions over global permissions
      board_permission = user.board_permission?(record.thread.board, :can_see_disabled_posts)

      # explicitly check for `false` as `nil` means: the access to disabled threads is not allowed nor denied
      return false if board_permission == false || (board_permission.nil? && user.permission?(:can_see_disabled_posts) == false)
    end

    true
  end

  def new?
    # deny access if user doesn't have access to the post's thread
    return false unless Pundit.policy(user, record.thread).show?

    true
  end

  def create?
    new?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope if scope.empty?

      # board specific permissions first, then group permissions
      board = scope.first.thread.board
      board_permission = user.board_permission?(board, :can_see_disabled_posts)
      return scope.all if board_permission

      # group permissions
      if board_permission != false && user.permission?(:can_see_disabled_posts)
        scope.all
      else
        scope.where(disabled: false)
      end
    end
  end
end
