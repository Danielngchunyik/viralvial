class PostPolicy < ApplicationPolicy

  def destroy?
    user.present? && record.user == user
  end

  def show?
    scope.where(id: record.id).exists?
    user.present? && record.user == user
  end
end
