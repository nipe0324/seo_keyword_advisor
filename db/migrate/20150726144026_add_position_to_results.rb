class AddPositionToResults < ActiveRecord::Migration
  def change
    add_column :results, :position, :integer
  end
end
