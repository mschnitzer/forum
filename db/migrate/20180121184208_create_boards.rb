class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.text :description, default: nil, null: true
      t.string :external_url, default: nil, null: true
      t.boolean :category, default: false, null: false
      t.integer :position, default: 1, null: false
    end
  end
end
