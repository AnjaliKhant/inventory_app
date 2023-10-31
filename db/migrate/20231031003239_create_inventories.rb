class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.references :store, null: false, foreign_key: true
      t.references :shoe, null: false, foreign_key: true
      t.integer :inventory_count

      t.timestamps
    end
  end
end
