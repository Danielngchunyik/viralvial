class AuthConstraint

  def matches?(request)
    request.session('user_role').admin?
  end
end