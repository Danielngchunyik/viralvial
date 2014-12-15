class CampaignPolicy < ApplicationPolicy
  include Campaigns::Filters

  def new?
    create?
  end

  def create?
    destroy?
  end

  def show?
    scope.where(id: record.id).exists?
    user.present? && record.conditions?(user)
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
