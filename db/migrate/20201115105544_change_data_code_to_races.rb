class ChangeDataCodeToRaces < ActiveRecord::Migration[5.1]
  def change
      change_column :races, :code, :string
  end
end
