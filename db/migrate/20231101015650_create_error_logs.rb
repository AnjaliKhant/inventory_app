class CreateErrorLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :error_logs do |t|
      t.string :error
      t.json   :data
      t.timestamps
    end
  end
end
