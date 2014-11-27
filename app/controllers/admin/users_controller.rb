class Admin::UsersController < AdminController
  before_action :set_user,
                :require_login,
                only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order("#{column_params[params[:sort].to_s] || 'id'} #{sort_direction}")
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created"
      redirect_to @user
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'new'
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:notice] = "User details updated"
      redirect_to @user
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'edit'
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      flash[:notice] = "User deleted"
      redirect_to admin_users_url
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      redirect_to @user
    end
  end

  private

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def column_params
    {
      'socialite' => "(users.scores -> 'socialite_score')::float(2)",
      'karma' => "(users.scores -> 'karma')::float(2)",
      'influence' => "(users.scores -> 'influence_score')::float(2)",
      'sx' => "(users.scores -> 'sx_index')::float(2)",
      'reach' => "(users.scores -> 'reach_score')::float(2)",
      'localization' => "(users.scores -> 'localization')::integer",
      'klout' => "(users.scores -> 'klout')::integer",
      'followers' => "(users.scores -> 'followers')::integer",
      'email' => 'email',
      'id' => 'id'
    }
  end

  def set_user  
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, authentication_attributes: [])
  end
end
