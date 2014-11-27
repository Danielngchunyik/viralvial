module UserHelper
  def render_direction
    case params[:direction]
    when 'desc'
      'asc'
    when 'asc'
      'desc'
    else
      'asc'
    end
  end
end
