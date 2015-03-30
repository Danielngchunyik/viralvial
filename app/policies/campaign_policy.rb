class CampaignPolicy < ApplicationPolicy
  
  def new?
    campaign_criteria
  end

  def create?
    new?
  end

  def destroy?
    create?
  end

  def show?
    scope.where(id: record.id).exists?
    (record.featured? && user.nil?) || create?
  end

  private

  def campaign_criteria
    user.present? && (record.conditions?(user) || record.has_user_invited?(user) ||  user.admin?)
  end
end
