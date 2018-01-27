class BoardThreadPolicy < ApplicationPolicy
  def new?
    Pundit.policy(user, record.board).show?
  end

  def create?
    new?
  end
end
