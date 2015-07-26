class CreateKeywordSets < ActiveRecord::Migration
  def change
    create_table :keyword_sets do |t|
      t.string :name
      t.datetime :analysed_at

      t.timestamps null: false
    end
  end
end
