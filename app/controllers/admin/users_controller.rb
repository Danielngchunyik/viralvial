class Admin::UsersController < UsersController
  helper_method :sort_direction

  def index
    @users = User.order("#{column_params[params[:sort].to_s] || 'id'} #{sort_direction}")
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
end