module UnitsHelper
  def unit_select(form, army_list, attribute_name, data: {})
    bootstrap_field_wrapper(form, attribute_name,
      form.collection_select(attribute_name, army_list.units.order(:name), :id, :name,
        {include_blank: "Please Select"}, {class: "form-select", data:}))
  end
end
