class CampaignPolicy < ApplicationPolicy
  include Campaigns::Filters

  def new?
    show?
  end

  def create_social_post?
    new?
  end

  def destroy?
    new?
  end

  def show?
    scope.where(id: record.id).exists?
    (user.present? && record.conditions?(user))
  end
end
