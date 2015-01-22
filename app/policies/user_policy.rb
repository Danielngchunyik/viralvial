class UserPolicy < ApplicationPolicy

  def show?
    scope.where(id: record.id).exists?
    edit?
  end

  def edit_interest?
    update?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (user.admin? || user == record)
  end
end
