class AnnouncementPolicy < ApplicationPolicy

  def show?
    scope.where(id: record.id).exists?
    edit?
  end

  def edit?
    update?
  end

  def update?
    destroy?
  end

  def destroy?
    user.present? && user.admin?
  end
end
