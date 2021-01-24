class CreateCouses < ActiveRecord::Migration[5.1]
  def change
    create_table :couses do |t|
      t.integer :couse_id
      t.string :couse_name
      t .string :place
      t .string :stage
      t .string :distance
      t .integer :speed, null: false, default: 1
      t .integer :power, null: false, default: 1
      t.timestamps
    end
  end
end
