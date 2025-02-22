class CreateUnitXpGainApplieds < ActiveRecord::Migration[7.1]
  def change
    create_table :unit_xp_gain_applieds, id: :uuid do |t|
      t.references :game, null: false, foreign_key: true, type: :uuid
      t.references :unit, null: false, foreign_key: true, type: :uuid
      t.references :unit_xp_gain_event, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
