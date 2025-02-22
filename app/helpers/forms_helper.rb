module FormsHelper
  def input_field_of_type(type, field_name, name, value = nil, disabled: false)
    case type
    when "number"
      number_field_tag(field_name, value, class: "form-control", placeholder: name, disabled: disabled)
    end
  end
end
