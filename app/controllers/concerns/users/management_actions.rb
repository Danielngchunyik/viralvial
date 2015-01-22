module Users::ManagementActions
  extend ActiveSupport::Concern

  included do
    before_action :set_user, :require_login,
                  only: [:show, :edit, :update, :change_password_and_email,
                         :destroy]
    before_action :set_options, only: :edit
    respond_to :html, :js
  end

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
      flash.clear
      flash[:notice] = "User details updated"
    else
      flash.clear
      flash[:error] = "error :#{@user.errors.full_messages}"
    end

    respond_with(@user) do |f|
      f.html { redirect_to @user }
    end
  end

  private

  def update_user_email_and_password(account)
    @user.update_password_and_email(account[:current_password],
                                         account[:email],
                                         account[:password],
                                         account[:password_confirmation])
  end

  def set_options
    @options = Option.first.interest_option_list
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
