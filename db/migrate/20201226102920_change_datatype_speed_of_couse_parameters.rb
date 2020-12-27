class ChangeDatatypeSpeedOfCouseParameters < ActiveRecord::Migration[5.1]
  def change
    change_column :couse_parameters, :speed, :float
  end
end
