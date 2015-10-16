class NoticesController < ApplicationController
  before_action :load_notice, only: [:show]

  def index
    @notices = Notice.where(project_id: session[:project_id])
  end

  def show
    session[:notice_id] = params[:id]
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    @notice[:project_id] = session[:project_id]

    if @notice.save
      redirect_to notice_path(@notice)
    else
      render :new
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
