class AddCodeTouma < ActiveRecord::Migration[5.1]
  def change
    add_column :umas, :code, :string
  end
end
