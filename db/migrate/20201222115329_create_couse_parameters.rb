class CreateCouseParameters < ActiveRecord::Migration[5.1]
  def change
    create_table :couse_parameters do |t|
      t.references :user, foreign_key: true
      t.references :couse, foreign_key: true
      t.float :speed, null: false, default: 1
      t.float :power, null: false, default: 1
      t.timestamps
    end
  end
end
