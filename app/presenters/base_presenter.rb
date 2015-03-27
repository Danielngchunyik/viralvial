class BasePresenter
  attr_reader :object, :user

  def initialize(object, user = nil)
    @user = user
    decorate_object
  end
end