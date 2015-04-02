class Admin::FeaturedsController < AdminController
  def create
    @featured = Featured.new(featured_params)

    if @featured.save
      flash[:notice] = "#{params[:featurable_type]} Featured"
      redirect_to admin_dashboarh_path
    end
  end

  def destroy
    @featured = Featured.find(params[:id])

    if @featured.destroy
      flash[:notice] = "Unfeatured!"
    else
      flash[:error] = "Error removing campaign from featured list!"
    end
    
    redirect_to admin_dashboard_path
  end

  private

  def featured_params
    params.require(:featured).permit(:featurable_id, :featurable_type)
  end
end