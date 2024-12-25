class User::BaseController < ApplicationController
  before_action :authorize_user

  private

  def authorize_user
    unless current_user&.user?
      redirect_to admin_root_path, alert: "You are not authorized to access this page."
    end
  end
end
