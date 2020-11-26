class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :uma, foreign_key: true
      t.integer :speed, null: false, default: 1
      t.integer :power, null: false, default: 1
      t.timestamps
    end
  end
end
