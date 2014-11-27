class UserPolicy < ApplicationPolicy

  def index?
    user.present? && user.admin?
  end

  def show?
    scope.where(id: record.id).exists?
    edit?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (user.admin? || user == record)
  end

  def destroy?
    user.admin?
  end
end
