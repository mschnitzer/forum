class AddParentIdColumnToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :parent_id, :integer, after: :description
  end
end
