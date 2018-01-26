class BoardThread < ApplicationRecord
  validates :title, presence: true
  validate :user_id_or_username_validation

  belongs_to :board
  belongs_to :user, optional: true
  belongs_to :deleted_by, class_name: 'User', optional: true
  has_many :posts, class_name: 'BoardThreadPost', foreign_key: :thread_id

  private

  def user_id_or_username_validation
    errors.add(:username, "can't be blank") if !user_id && username.blank?
  end
end
