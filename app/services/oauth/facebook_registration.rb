class Oauth::FacebookRegistration
  attr_accessor :token, :user
  
  def initialize(token, user)
    @token = token
    @user = user
  end

  def save
    fb_user = FbGraph::User.fetch("me?access_token=#{@token}")
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    location_array = fb_user.location.name.split(', ')

    @user.update(birthday: fb_user.birthday,
                 religion: fb_user.religion.downcase,
                 location: location_array[0].downcase,
                 marital_status: fb_user.relationship_status.downcase,
                 country: IsoCountryCodes.search_by_name(location_array[1])[0].alpha2)
  end
end
