class Board < ApplicationRecord
  validates :name, presence: true

  has_many :boards, foreign_key: :parent_id
  scope :categories, -> { where(category: true) }

  def boards?
    boards.count > 0
  end
end
