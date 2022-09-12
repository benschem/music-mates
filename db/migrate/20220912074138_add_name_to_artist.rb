class AddNameToArtist < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :name, :string
  end
end
