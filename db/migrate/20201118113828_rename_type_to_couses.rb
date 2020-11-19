class RenameTypeToCouses < ActiveRecord::Migration[5.1]
  def change
    rename_column :couses, :type, :stage
  end
end
