class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.integer :code
      t.string :name
      t.string :distance
      t.string :type
      t.string :condition

      t.timestamps
    end
  end
end
