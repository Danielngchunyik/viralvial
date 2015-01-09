module Campaigns::Invitations

  module ClassMethods
    def invited?(user)
      select do |campaign|
        campaign.has_user_invited?(user)
      end
    end
  end

  def has_user_invited?(user)
    self.private && (user.name.present? && invitation_list.include?(user.name)) && end_date > Date.today
  end
end
