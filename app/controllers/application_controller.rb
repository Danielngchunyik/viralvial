class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def current_country
    return unless set_location
    @current_country ||= "#{@location.country_name}"
  end
  helper_method :current_country

  def current_city
    return unless set_location
    @current_city ||= "#{@location.city_name}"
  end
  helper_method :current_city

  def not_authenticated
    flash[:error] = 'Please login first'
    redirect_to root_path
  end

  def set_location
    @location = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip)
  end
end
