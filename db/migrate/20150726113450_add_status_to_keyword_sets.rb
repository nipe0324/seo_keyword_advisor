class AddStatusToKeywordSets < ActiveRecord::Migration
  def change
    add_column :keyword_sets, :status, :integer, null: false, default: 0, limit: 1
  end
end
