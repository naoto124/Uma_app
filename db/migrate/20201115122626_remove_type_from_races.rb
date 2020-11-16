class RemoveTypeFromRaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :races, :type, :string
  end
end
