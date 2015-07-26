class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :keyword, index: true, foreign_key: true
      t.string :url
      t.string :domain
      t.string :title
      t.text :desc

      t.timestamps null: false
    end
  end
end
