class CreateUnitTraitCategoryMappings < ActiveRecord::Migration[7.1]
  def change
    create_table :unit_trait_category_mappings, id: :uuid do |t|
      t.references :mapped_to, polymorphic: true
      t.references :unit_trait_category, null: false, foreign_key: true, type: :uuid
      t.integer :order

      t.timestamps
    end
  end
end
