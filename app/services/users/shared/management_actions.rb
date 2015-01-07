module Users::Shared::ManagementActions
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = successful_creation_message
      redirect_to successful_redirection_path
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
      redirect_to successful_redirection_path
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'edit'
    end
  end

  def change_password_and_email
    authorize @user

    account = params[:user]

    if account[:password] == account[:password_confirmation]
      if update_user_email_and_password(account)

        flash[:notice] = "User details updated"
        redirect_to successful_redirection_path
      else
        flash[:error] = "Wrong current password"
        render action: 'edit'
      end
    else
      flash[:error] = "Passwords do not match"
      render action: 'edit'
    end
  end

  private

  def update_user_email_and_password(account)
    @user.update_password_and_email(account[:current_password], 
                                         account[:email], 
                                         account[:password], 
                                         account[:password_confirmation])
  end
  
  def set_user  
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :blog_url, 
                                  :password_confirmation, :name, 
                                  :birthday, :gender, :race, :religion, 
                                  :contact_number, :nationality, :location, :country, 
                                  :marital_status, :role, :main_interest, :secondary_interest_list,
                                  authentication_attributes: [])
  end
end
