class AddSpotifyLinkToArtist < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :spotify_link, :string
  end
end
