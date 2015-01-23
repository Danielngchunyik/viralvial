class Posts::Delete::Twitter < Posts::TwitterBase

  def destroy
    @twitter.destroy_status(@post.external_post_id)
  end
end
