class Admin::UsersController < AdminController

  def index
    @users = User.order("#{column_name} #{direction}")
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

  def change_password_and_email
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

  def successful_creation_message
    "User created"
  end

  def successful_redirection_path
    [:admin, @user]
  end

  def column_name
    column_params[params[:sort].to_s] || 'id'
  end

  def direction
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
end
