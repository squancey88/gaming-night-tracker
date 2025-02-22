module WithinWorld
  extend ActiveSupport::Concern

  included do
    prepend_before_action :check_world
    prepend_before_action :set_world
    before_action :new_record, only: %i[new] # standard:disable Rails/LexicallyScopedActionFilter
  end

  def check_world
    redirect_to worlds_url unless session[:world_id]
  end

  def set_world
    @world_building = true
    @world = World.find(session[:world_id])
  end

  private

  def new_record(values = {})
    instance_variable_set(:"@#{controller_name.singularize}", controller_name.classify.constantize.new(world: @world, **values))
  end

  def set_records
    @pagy, records = pagy(@world.send(controller_name))
    instance_variable_set(:"@#{controller_name}", records)
  end
end
