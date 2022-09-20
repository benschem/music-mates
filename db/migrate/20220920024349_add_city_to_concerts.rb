class AddCityToConcerts < ActiveRecord::Migration[7.0]
  def change
    add_column :concerts, :city, :string
  end
end
