class Admin::UsersController < UsersController
  def index
    @users = User.order(params[:sort])
  end
end