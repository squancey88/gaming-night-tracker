module UnitXpGainEventsHelper
  def unit_xp_gain_event_select(form, game_system, attribute_name, data: {})
    bootstrap_field_wrapper(form, attribute_name,
      form.collection_select(attribute_name, game_system.unit_xp_gain_events.active.order(:name), :id, :name,
        {include_blank: "Please Select"}, {class: "form-select", data:}))
  end
end
