class CreateUnitXpGainEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :unit_xp_gain_events, id: :uuid do |t|
      t.string :name
      t.jsonb :description
      t.integer :xp_gain
      t.references :game_system, null: false, foreign_key: true, type: :uuid
      t.boolean :active

      t.timestamps
    end
  end
end
