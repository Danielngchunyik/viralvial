class Admin::TasksController < AdminController
  def new
    @task = @campaign.tasks.build
  end

  def create
    @task = 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end