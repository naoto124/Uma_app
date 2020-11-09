class AddUmainfoToUmas < ActiveRecord::Migration[5.1]
  def change
    add_column :umas, :age, :integer
    add_column :umas, :sex, :string
    add_column :umas, :father, :string
    add_column :umas, :mother, :string
  end
end
