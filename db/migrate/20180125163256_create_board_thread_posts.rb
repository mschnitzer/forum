class CreateBoardThreadPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :board_thread_posts do |t|
      t.integer :thread_id
      t.integer :user_id
      t.string :username
      t.boolean :user_deleted, default: 0, null: false
      t.string :title
      t.text :message, limit: 16777215
      t.boolean :thread_starter, default: 0, null: false
      t.boolean :closed, default: 0, null: false
      t.boolean :deleted, default: 0, null: false
      t.integer :deleted_by_id, default: nil, null: true
      t.datetime :deleted_at, default: nil, null: true
      t.timestamps
    end
  end
end
