class RenameDistanceColumnToRaces < ActiveRecord::Migration[5.1]
  def change
    rename_column :races, :distance, :type_distance
  end
end
