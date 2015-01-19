module SocialMediaHelper
  def social_media(post)
    case post.type
    when "FacebookPost"
      "Facebook"
    when "TwitterPost"
      "Twitter"
    end
  end
end