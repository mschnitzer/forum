class BoardThreadPost < ApplicationRecord
  validates :title, presence: true
  validates :message, presence: true
  validate :user_id_or_username_validation

  belongs_to :thread, class_name: 'BoardThread', optional: true
  belongs_to :user, optional: true
  belongs_to :deleted_by, class_name: 'User', optional: true

  def author_name
    username ? username : user.username
  end

  def formatted_author_name
    user ? user.formatted_username : username
  end

  private

  def user_id_or_username_validation
    errors.add(:username, "can't be blank") if !user_id && username.blank?
  end
end
