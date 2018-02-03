class AddDisabledColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :board_thread_posts, :disabled, :boolean, default: false, after: :closed
  end
end
