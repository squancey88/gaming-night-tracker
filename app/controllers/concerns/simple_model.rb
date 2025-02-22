module SimpleModel
  extend ActiveSupport::Concern

  included do
    before_action :set_record, only: %i[show update destroy]
    before_action :set_records, only: %i[index]
  end

  def index
    render "common/simple_index"
  end

  def new
    @record = new_record
    render "common/simple_show_edit"
  end

  def show
    render "common/simple_show_edit"
  end

  def create
    @record = new_record(record_params)

    respond_to do |format|
      if @record.save
        format.html {
          redirect_to @record, notice: "#{@record.class.model_name.human} was successfully created."
        }
      else
        format.html { render "common/simple_show_edit", status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html {
          render "common/simple_show_edit", notice: "Type was successfully updated."
        }
      else
        format.html {
          render "common/simple_show_edit", status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    @record.destroy!

    respond_to do |format|
      format.html { redirect_to root_url, notice: "#{@record.class.model_name.human} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def new_record(values = {})
    controller_name.classify.constantize.new(**values)
  end

  def set_record
    @record = controller_name.classify.constantize.find(params[:id])
  end

  def set_records
    @pagy, @records = pagy(controller_name.classify.constantize.all)
  end
end
