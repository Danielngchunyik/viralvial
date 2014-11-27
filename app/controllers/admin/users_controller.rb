class Admin::UsersController < UsersController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  private

  def sort_column
    column_params.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def column_params
    column_params = [
      "(users.scores -> 'socialite_score')::float(2)",
      "(users.scores -> 'karma')::float(2)",
      "(users.scores -> 'influence_score')::float(2)",
      "(users.scores -> 'sx_index')::float(2)",
      "(users.scores -> 'reach_score')::float(2)",
      "(users.scores -> 'localization')::integer",
      "(users.scores -> 'klout')::integer",
      "(users.scores -> 'followers')::integer",
      "email",
      "id",
    ]
  end
end