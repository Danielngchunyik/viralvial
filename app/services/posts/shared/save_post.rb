module Posts::Shared::SavePost

  def save_post!(ext_id, ext_type)
    @post = @current_user.posts.build(@post_params.merge(external_post_id: ext_id, 
                                                         external_post_id_type: ext_type,
                                                         campaign_id: @campaign_id
                                                         ))
    @post.save
  end
end
