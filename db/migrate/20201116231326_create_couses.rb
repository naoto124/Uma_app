class CreateCouses < ActiveRecord::Migration[5.1]
  def change
    create_table :couses do |t|
      t.integer :couse_id
      t.string :couse_name

      t.timestamps
    end
  end
end
