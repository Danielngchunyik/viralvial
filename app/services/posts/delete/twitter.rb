class Posts::Delete::Twitter < Posts::TwitterBase

  def destroy
    begin
      @twitter.client.destroy_status(@post.external_post_id)
    rescue
    end
  end
end
