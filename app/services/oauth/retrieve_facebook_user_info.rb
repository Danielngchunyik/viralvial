class Oauth::RetrieveFacebookUserInfo
  attr_accessor :token, :user
  
  def initialize(token, user)
    @token = token
    @user = user
  end

  def save
    fb_user = FbGraph::User.fetch("me?access_token=#{@token}")
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    
    user_location = fb_user.location.present? ? fb_user.location.name.split(', ') : ["None", "Malaysia"]

    @user.update(birthday: fb_user.birthday,
                 religion: fb_user.religion,
                 location: user_location[0],
                 marital_status: fb_user.relationship_status,
                 country: IsoCountryCodes.search_by_name(user_location[1])[0].alpha2)
  end
end
