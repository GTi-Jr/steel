class PagesController < ApplicationController
  layout "blank"

  def home
    redirect_to projects_path if current_user.present?
  end

  def dashboard
    @customers = User.all
    @projects = Projects.all.limit
  end
end
