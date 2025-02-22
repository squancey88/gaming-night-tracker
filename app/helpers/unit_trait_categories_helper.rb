module UnitTraitCategoriesHelper
  def unit_trait_category_select(form, attribute, game_system, data: {})
    bootstrap_field_wrapper(form, attribute,
      form.collection_select(attribute, game_system.unit_trait_categories.order(:name), :id, :name,
        {include_blank: "Please Select"}, {class: "form-select", data:}))
  end

  def unit_trait_category_list(record)
    content_tag :div do
      record.unit_trait_category_mappings.map do |category_mapping|
        concat(content_tag(:div) do
          concat(content_tag(:strong, "#{category_mapping.precedence.titlecase}: "))
          concat(content_tag(:span, category_mapping.unit_trait_category.name))
        end)
      end
    end
  end
end
