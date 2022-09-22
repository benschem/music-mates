class ChangeDateColumnFromConcerts < ActiveRecord::Migration[7.0]
  def change
    change_column :concerts, :date, :datetime
  end
end
