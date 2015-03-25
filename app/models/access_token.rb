class AccessToken
  attr_accessor :token, :secret

  def initialize(token, secret)
    @token = token
    @secret = secret
  end
end
