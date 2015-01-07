module Posts::Shared::SavePost

  def save_post!(ext_id, ext_type)
    @post = @current_user.posts.build(@post_params)
    @post.external_post_id = ext_id
    @post.external_post_id_type = ext_type
    @post.campaign_id = @campaign_id
    @post.save
  end
end
