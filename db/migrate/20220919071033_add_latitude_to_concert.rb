class AddLatitudeToConcert < ActiveRecord::Migration[7.0]
  def change
    add_column :concerts, :latitude, :string
    add_column :concerts, :longitude, :string
  end
end
