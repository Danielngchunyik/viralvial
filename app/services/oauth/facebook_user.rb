class Oauth::FacebookUser
  attr_accessor :access_token, :user, :country, :new_user
  
  def initialize(access_token, country = nil, user = nil)
    @access_token = access_token
    @country = country
    @user = user
  end

  def save
    
    # Create new user
    set_user_params
    set_user_location

    @new_user = User.create!(name: @fb_user.name, email: @fb_user.email,
                        birthday: @fb_user.birthday, location: @user_location[0],
                        country: IsoCountryCodes.search_by_name(country)[0].alpha2,
                        remote_image_url: "#{@fb_user.picture}?redirect=1&height=300&type=normal&width=300")

    # Build user associations
    create_auth_and_followers
    
    SocialScore::CalculatePercentile.new.perform
    
    @new_user
  end

  def update_followers
    set_user_params

    return if user.social_score.facebook_followers == @fb_user.friends.total_count
    user.social_score.update(facebook_followers: @fb_user.friends.total_count)
  end

  private

  def set_user_params
    @fb_user = FbGraph::User.me(access_token.token).fetch    
  end

  def set_user_location
    @user_location = @fb_user.location.present? ? @fb_user.location.name.split(', ') : ["None"]
  end

  def create_auth_and_followers
    @new_user.build_social_score(facebook_followers: @fb_user.friends.total_count).save
    @new_user.authentications.build(provider: 'facebook', uid: @fb_user.identifier, token: access_token.token).save
  end
end
