class CreateUmas < ActiveRecord::Migration[5.1]
  def change
    create_table :umas do |t|
      t.string :name
      t.string :code
      t.timestamps
    end
  end
end
