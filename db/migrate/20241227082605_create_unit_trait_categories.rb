class CreateUnitTraitCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :unit_trait_categories, id: :uuid do |t|
      t.string :name
      t.references :game_system, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    change_table :unit_traits do |t|
      t.references :unit_trait_category, null: true, foreign_key: true, type: :uuid
    end
  end
end
