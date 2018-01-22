class CreateBoardThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :board_threads do |t|
      t.string :title
      t.integer :board_id
      t.integer :user_id
      t.string :username
      t.boolean :user_deleted, default: false, null: false
      t.boolean :sticky, default: false, null: false
      t.boolean :announcement, default: false, null: false
      t.boolean :closed, default: false, null: false
      t.boolean :disabled, default: false, null: false
      t.boolean :deleted, default: false, null: false
      t.integer :deleted_by_id, default: nil
      t.datetime :deleted_at, default: nil
      t.timestamps
    end
  end
end
