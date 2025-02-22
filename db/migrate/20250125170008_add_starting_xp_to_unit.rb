class AddStartingXpToUnit < ActiveRecord::Migration[7.1]
  def change
    add_column :units, :starting_xp, :integer, default: 0, null: false
  end
end
