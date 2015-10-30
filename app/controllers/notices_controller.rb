class NoticesController < ApplicationController
  layout "dashboard"
  before_action :load_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.where(project_id: session[:project_id])
  end

  def show
    session[:notice_id] = params[:id]
  end

  def new
    if current_user.is_admin?
      @notice = Notice.new
    else
      redirect_to project_path(Project.find(session[:project_id]))
    end
  end

  def create
    @notice = Notice.new(notice_params)
    @notice[:project_id] = session[:project_id]

    if @notice.save
      redirect_to project_path(@notice.project)
    else
      render :new
    end
  end

  def edit        
    @notice = Notice.find(params[:id])
  end

  def update
    if current_user.is_admin?
      if @notice.update_attributes(notice_params)  
        redirect_to project_path(@notice.project)
      else  
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    auxiliar_notice = @notice
    if current_user.is_admin?
      if @notice.destroy
        redirect_to project_path(auxiliar_notice.project)
      else
        redirect_to project_path(auxiliar_notice.project)
      end
    else
      redirect_to root_path
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:title, :description)
  end

  def load_notice
    @notice = Notice.find(params[:id])
  end
end
