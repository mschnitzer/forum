class BoardThread < ApplicationRecord
  belongs_to :board
  belongs_to :user, optional: true
  belongs_to :deleted_by, class_name: 'User', optional: true
end
