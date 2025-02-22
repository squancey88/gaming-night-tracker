class UnitTraitCategoriesController < ApplicationController
  include SimpleModel
  include GameSystemPart

  def add_category_row
    set_game_system
    type = params[:type]
    helpers.fields type.classify.constantize.new do |f|
      f.fields_for :unit_trait_category_mappings, UnitTraitCategoryMapping.new, child_index: Time.now.to_i do |ff|
        render turbo_stream: turbo_stream.append(
          "unit_trait_category_mappings",
          partial: "unit_trait_category_mappings/form_row",
          locals: {form: ff, game_system: @game_system}
        )
      end
    end
  end

  private

  def record_params
    params.require(:unit_trait_category).permit(:name, :game_system_id)
  end
end
