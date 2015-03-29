module ShareableImages
  extend ActiveSupport::Concern

  def fetch_shareable_images
    @images = []
    
    # Fetch default images
    @topic.default_images.each do |image|
      @images << image
    end

    # Fetch user uploaded image if available
    if user_image = @topic.user_images.find_by(user_id: current_user.id)
      @images << user_image
    end
  end
end