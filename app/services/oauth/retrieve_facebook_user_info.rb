class Oauth::RetrieveFacebookUserInfo
  attr_accessor :token, :user
  
  def initialize(token, user)
    @token = token
    @user = user
  end

  def save
    fb_user = FbGraph::User.me(@token).fetch
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    
    user_location = fb_user.location.present? ? fb_user.location.name.split(', ') : ["None", "Malaysia"]

    @user.update(birthday: fb_user.birthday,
                 location: user_location[0],
                 country: IsoCountryCodes.search_by_name(user_location[1])[0].alpha2)
    @user.followers.create(social_platform: "Facebook", amount: fb_user.friends.total_count)
  end
end
