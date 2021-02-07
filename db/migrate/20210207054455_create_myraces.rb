class CreateMyraces < ActiveRecord::Migration[5.1]
  def change
    create_table :myraces do |t|
      t.references :user, foreign_key: true
      t.references :race, foreign_key: true
      t.integer :code
      t.float :speed, null: false, default: 1
      t.float :power, null: false, default: 1
      t.timestamps
    end
  end
end
