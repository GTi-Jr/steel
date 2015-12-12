class NoticesController < ApplicationController
  layout "dashboard"
  before_action :load_notice, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:show]
  before_action :admin_only, only: [:new, :edit, :create, :update, :destroy]

  def index
    @notices = Notice.where(project_id: session[:project_id])
    
  end

  def show
    session[:notice_id] = params[:id]
    @attachments = Attachment.where(notice_id: session[:notice_id])
  end

  def new
    @notice = Notice.new
    @attachments = @notice.attachments.build
  end

  def create
    @notice = Notice.new(notice_params)
    @notice[:project_id] = session[:project_id]

    if @notice.save
      NoticeMailer.notice_created_mail(@notice).deliver_later
      
      unless params[:attachments].nil?
        params[:attachments]['image'].each do |a|
          @attachments = @notice.attachments.create!(:image => a)
        end
      end
      
      redirect_to project_path(@notice.project)
    else
      render :new
    end
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
      if @notice.update_attributes(notice_params)
        redirect_to project_path(@notice.project)
      else
        render :edit
      end
  end

  def destroy
    auxiliar_notice = @notice
    if @notice.destroy
      redirect_to project_path(auxiliar_notice.project)
    else
      redirect_to project_path(auxiliar_notice.project)
    end
  end

  private
  def notice_params
    params.require(:notice).permit(:title, :description, attachments_attributes: [:id, :notice_id, :image])
  end

  def load_notice
    @notice = Notice.find(params[:id])
  end

  def check_user
    redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.has_project(@notice.project) || current_user.is_admin?
  end

  def admin_only
    redirect_to root_path, notice: t('alerts.admin_privileges') unless current_user.is_admin?
  end
end