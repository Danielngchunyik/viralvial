class Oauth::RetrieveFacebookUserInfo
  attr_accessor :access_token, :user, :country
  
  def initialize(access_token, country)
    @access_token = access_token
    @country = country
  end

  def save
    @fb_user = FbGraph::User.me(access_token.token).fetch
    
    user_location = @fb_user.location.present? ? @fb_user.location.name.split(', ') : ["None"]

    @user = User.create(name: @fb_user.name, email: @fb_user.email,
                     birthday: @fb_user.birthday, location: user_location[0],
                     country: IsoCountryCodes.search_by_name(country)[0].alpha2,
                     remote_image_url: "#{@fb_user.picture}?redirect=1&height=300&type=normal&width=300")

    create_new_authentication
    
    return @user
  end

  private

  def create_new_authentication
    @user.authentications.build(provider: 'facebook', uid: @fb_user.identifier, token: access_token.token).save
  end
end
