class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|
      t.string  :name, null: false, limit: 50
      t.timestamps
    end
  end
end
