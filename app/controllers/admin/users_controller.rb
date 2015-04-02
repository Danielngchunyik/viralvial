class Admin::UsersController < AdminController
  before_action :set_user, except: [:index, :new]

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def create
    @user = User.new(user_params.merge(role: "admin"))

    if @user.save
      flash[:notice] = "New user created"
      redirect_to admin_user_path(@user)
    else
      flash[:error] = "Error!"
      render :new
    end
  end

  def index
    @users = User.admin_order(params[:sort], params[:direction])
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User deleted"
      redirect_to admin_users_path
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
