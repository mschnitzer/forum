class Board < ApplicationRecord
  validates :name, presence: true

  belongs_to :parent, class_name: 'Board', optional: true
  has_many :boards, foreign_key: :parent_id
  has_many :threads, class_name: 'BoardThread'
  scope :categories, -> { where(category: true) }

  has_many :board_permission_to_targets

  def boards?
    boards.count.positive?
  end

  def to_param
    [id, name.parameterize].join('-')
  end

  def to_s
    name
  end
end
