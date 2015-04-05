class Admin::OptionsController < AdminController
  before_action :set_option
  respond_to :html, :json

  def edit
  end
  
  def update
    @option.update(option_params)
    respond_with(@option)
  end

  private

  def set_option
    @option = Option.first
  end

  def option_params
    params.require(:option).permit(:category_list)
  end
end