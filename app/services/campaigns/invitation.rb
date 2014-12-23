module Campaigns::Invitation

  module ClassMethods
    def invited?(user)
      select do |campaign|
        campaign.in_invite_list?(user)
      end
    end
  end

  def in_invite_list?(user)
    private && (invitation_list.blank? || (user.name.present? && invitation_list.include?(user.name)))
  end
end