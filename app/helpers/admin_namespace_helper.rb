module AdminNamespaceHelper
  def admin?
    controller.class.name.split("::").first=="Admin"
  end
end