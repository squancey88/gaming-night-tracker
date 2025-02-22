class ConvertUnitStatModifiersDescriptionToJson < ActiveRecord::Migration[7.1]
  include ApplicationHelper
  def change
    add_column :unit_stat_modifiers, :rich_description, :jsonb

    UnitStatModifier.find_each do |mod|
      mod.rich_description = simple_text_to_rich(mod.description)
      mod.save!
    end
  end
end
