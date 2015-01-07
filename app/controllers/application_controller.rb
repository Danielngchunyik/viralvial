class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def current_location
    if get_location
      @current_location ||= "#{@location.city_name}, #{@location.country_name}"
    end
  end
  helper_method :current_location
  
  def not_authenticated
    flash[:alert] = 'Please login first'
    redirect_to login_path
  end

  def get_location
    @location = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip)
  end
end
