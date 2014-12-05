module UserManagementActions
  
 def self.included(base)
    base.before_action :set_user,
                       :require_login,
                       only: [:show, :edit, :update, :destroy]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = successful_creation_message
      redirect_to successful_redirection_url
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'new'
    end
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:notice] = "User details updated"
      redirect_to successful_redirection_url
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'edit'
    end
  end

  private
  
  def set_user  
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, 
                                  :password_confirmation, :name, 
                                  :birthday, :gender, :race, :religion, 
                                  :contact_number, :nationality, :location, :country, 
                                  :marital_status, :role, authentication_attributes: [])
  end
end