class AddPlaceToCouses < ActiveRecord::Migration[5.1]
  def change
    add_column :couses, :place, :string
    add_column :couses, :type, :string
    add_column :couses, :distance, :string
    add_column :couses, :speed, :integer, null: false, default: 1
    add_column :couses, :power, :integer, null: false, default: 1
  end
end
