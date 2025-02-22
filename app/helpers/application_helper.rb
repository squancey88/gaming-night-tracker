module ApplicationHelper
  include Pagy::Frontend

  def column_row_classes
    %i[row row-cols-1 row-cols-md-2 g-2]
  end

  def column_row_class
    column_row_classes.join(" ")
  end

  def grid_classes(row_cols)
    "row row-cols-md-#{row_cols} g-2 row-cols-1"
  end

  def simple_text_to_rich(text)
    {
      time: DateTime.now.to_i,
      version: "2.29.1",
      blocks: [
        {
          type: :paragraph,
          data: {
            text:
          },
          id: SecureRandom.base64(10)
        }
      ]
    }.to_json
  end

  def bootstrap_precedence_select(form, attribute)
    bootstrap_field_wrapper(form, attribute,
      form.select(attribute, options_for_select(Precedence.map.map { |k, v| [v.titlecase, k] }),
        {include_blank: "Please Select"}, {class: "form-select"}))
  end
end
