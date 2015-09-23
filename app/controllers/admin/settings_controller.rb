class Admin::SettingsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  def edit
    @setting = Setting
  end

  def update
    Setting.update_attributes(setting_params)
    flash[:toastr] = ['Setting updated!']
    redirect_to admin_settings_edit_path
  end

  private

  def setting_params
    params.require(:setting).permit(:page_name, :start_number, :categories,
      :auto_post)
  end
end
