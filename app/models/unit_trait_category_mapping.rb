class UnitTraitCategoryMapping < ApplicationRecord
  belongs_to :unit_trait_category
  belongs_to :mapped_to, polymorphic: true

  def precedence
    Precedence.label(order)
  end
end
