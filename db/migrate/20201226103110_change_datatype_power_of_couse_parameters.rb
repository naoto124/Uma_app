class ChangeDatatypePowerOfCouseParameters < ActiveRecord::Migration[5.1]
  def change
        change_column :couse_parameters, :power, :float

  end
end
