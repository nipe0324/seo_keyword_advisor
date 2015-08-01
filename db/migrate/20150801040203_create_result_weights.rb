class CreateResultWeights < ActiveRecord::Migration
  def change
    create_table :result_weights do |t|
      t.integer :position, null: false
      t.float :weight, null: false

      t.timestamps null: false
    end
		add_index :result_weights, :position, unique: true
  end
end
