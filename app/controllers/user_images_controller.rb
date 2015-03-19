class UserImagesController < ApplicationController
  before_action :set_campaign, :set_topic, :require_login

  def create
    delete_current_image!

    @user_image = @topic.user_images.build(user_image_params)
    @user_image.user = current_user

    if @user_image.save
      redirect_to root_path
      flash[:notice] = "Success"
    else
      redirect_to root_path
      flash[:error] = "Fail"
    end
  end

  private

  def delete_current_image!
    if current_image = @topic.user_images.where(user_id: current_user.id).first
      current_image.remove_storage!
      current_image.delete
    end
  end

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_topic
    @topic = @campaign.topics.find(params[:topic_id])
  end

  def user_image_params
    params.require(:user_image).permit(:storage, :user_id, :topic_id)
  end
end