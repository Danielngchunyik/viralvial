class Admin::AnnouncementsController < AdminController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login

  def index
    @announcements = Announcement.order("created_at DESC")
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      flash[:notice] = "Announcement created"
    else
      flash[:error] = "Error"
    end
    redirect_to admin_announcements_path
  end

  def edit
  end

  def update
    if @announcement.update(announcement_params)
      flash[:notice] = "Announcement updated"
    else
      flash[:error] = "Error"
    end
    redirect_to admin_announcements_path
  end

  def destroy
    if @announcement.destroy
      flash[:alert] = 'deleted'
      redirect_to admin_announcements_path
    else
      flash[:error] = 'error'
    end
  end

  private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:message, :title)
  end
end