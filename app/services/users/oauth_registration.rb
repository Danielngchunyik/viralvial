class Users::OauthRegistration
  attr_accessor :token, :provider, :user
  
  def initialize(token, provider, user)
    @token = token
    @provider = provider
    @user = user
  end

  def save
    save_access_token

    fb_user = FbGraph::User.fetch("me?access_token=#{@token}")
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    location_array = fb_user.location.name.split(', ')

    @user.update(birthday: fb_user.birthday,
                 location: location_array[0],
                 country: IsoCountryCodes.search_by_name(location_array[1])[0].alpha2)
  end

  private
  
  def save_access_token
    auth = @user.authentications.find_by(provider: provider)
    auth.update(token: @token)
  end
end
