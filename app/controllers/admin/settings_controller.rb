class Admin::SettingsController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  def edit
    @setting = Setting
    @fb_pages = PublishToFbService.instance.get_admin_pages(auth_token) if auth_token
  end

  def update
    Setting.update_attributes(setting_params)
    Setting.update_fb_token if setting_params.include?(:fb_page)
    flash[:toastr] = 'Setting updated!'
    redirect_to admin_settings_edit_path
  end

  protected

  def auth_token
    request.env['omniauth.auth'] && request.env['omniauth.auth'].credentials.token
  end

  private

  def setting_params
    params.require(:setting).permit(:page_name, :start_number, :categories,
      :auto_post, :fb_page)
  end
end
