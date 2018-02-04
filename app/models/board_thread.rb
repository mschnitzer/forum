class BoardThread < ApplicationRecord
  validates :title, presence: true
  validate :user_id_or_username_validation

  belongs_to :board
  belongs_to :user, optional: true
  belongs_to :deleted_by, class_name: 'User', optional: true
  has_many :posts, class_name: 'BoardThreadPost', foreign_key: :thread_id

  def author_name
    username ? username : user.username
  end

  def formatted_author_name
    user ? user.formatted_username : username
  end

  def last_answer
    posts_without_thread_starter.order(id: :desc).limit(1).first
  end

  def posts_without_thread_starter
    posts.where(thread_starter: false)
  end

  def to_param
    [id, title.parameterize].join('-')
  end

  private

  def user_id_or_username_validation
    errors.add(:username, "can't be blank") if !user_id && username.blank?
  end
end
