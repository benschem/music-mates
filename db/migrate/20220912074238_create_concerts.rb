class CreateConcerts < ActiveRecord::Migration[7.0]
  def change
    create_table :concerts do |t|
      t.references :artist, null: false, foreign_key: true
      t.date :date
      t.string :location
      t.text :description
      t.string :venue

      t.timestamps
    end
  end
end
