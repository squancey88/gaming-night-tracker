module UnitStatModifiersHelper
  def unit_stat_modifier_select(form, game_system, attribute_name, data: {})
    bootstrap_field_wrapper(form, attribute_name,
      form.collection_select(attribute_name, game_system.unit_stat_modifiers.active.order(:name), :id, :name,
        {include_blank: "Please Select"}, {class: "form-select", data:}))
  end
end
