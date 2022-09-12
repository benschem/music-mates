class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :concert, null: false, foreign_key: true

      t.timestamps
    end
  end
end
