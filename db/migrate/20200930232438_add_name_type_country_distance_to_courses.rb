class AddNameTypeCountryDistanceToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :name, :string
    add_column :courses, :type, :string
    add_column :courses, :country, :string
    add_column :courses, :distance, :integer
  end
end
