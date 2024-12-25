class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  private

  def authorize_admin
    unless current_user&.admin?
      redirect_to user_root_path, alert: "You are not authorized to access this page."
    end
  end
end
