class Posts::Twitter::Delete < Posts::TwitterBase

  def destroy
    @twitter.client.destroy_status(@post.external_post_id)
  rescue
  end
  
end
