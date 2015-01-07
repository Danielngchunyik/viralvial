class UserImagesController < ApplicationController
  before_action :set_campaign

  def create
    if @current_image = @campaign.user_images.where(user_id: current_user.id).first
      @current_image.delete
    end
    
    @user_image = @campaign.user_images.build(user_image_params)
    @user_image.user = current_user

    if @user_image.save
      redirect_to :back
      @campaign.reload
      flash[:success] = "Success"
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def user_image_params
    params.require(:user_image).permit(:storage, :user_id, :campaign_id)
  end
end