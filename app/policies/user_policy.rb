class UserPolicy < ApplicationPolicy

  def show?
    scope.where(id: record.id).exists?
    edit?
  end

  def edit?
    update?
  end

  def change_password_and_email?
    user.present? && user.admin?
  end

  def update?
    user.present? && (user.admin? || user == record)
  end
end
