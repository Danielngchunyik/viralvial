class Provider::Base
  attr_accessor :token, :user, :post, :post_params, :topic_id, :post_service

  def initialize(user, post, post_params, topic_id)
    @user = user
    @post = post # To retrieve
    @post_params = post_params # To publish
    @topic_id = topic_id

    set_token
  end

  def to_s
    name.capitalize
  end

  def name
    implement_me! __method__.to_s
  end

  def post_type
    implement_me! __method__.to_s
  end

  def retrieve_post
    implement_me! __method__.to_s
  end

  def remove_post!
    implement_me! __method__.to_s
  end

  def publish!
    implement_me! __method__.to_s
  end

  private

  def set_token
    implement_me! __method__.to_s
  end

  def implement_me!(method_name)
    fail "Implement `#{method_name}` in the provider!"
  end
end
