module Campaigns::Filters

  module ClassMethods
    def targeted_at(user)
      select do |campaign|
        campaign.conditions?(user)
      end
    end
  end

  def conditions?(user)
    [
      min_age?(user), 
      max_age?(user), 
      min_socialite_score?(user), 
      max_socialite_score?(user), 
      religion?(user), 
      country?(user), 
      race?(user), 
      categories?(user)
    ].all?
  end

  def min_age?(user)
    min_age.blank? || (user.age.present? && user.age >= min_age.to_i)
  end

  def max_age?(user)
    max_age.blank? || (user.age.present? && user.age <= max_age.to_i)
  end

  def min_socialite_score?(user)
    min_socialite_score.blank? || 
    (user.socialite_score.present? && user.socialite_score.to_i >= min_socialite_score.to_i)
  end

  def max_socialite_score?(user)
    max_socialite_score.blank? ||
    (user.socialite_score.present? && user.socialite_score.to_i <= max_socialite_score.to_i)
  end

  def religion?(user)
    religion_list.blank? || (user.religion.present? && religion_list.include?(user.religion))
  end

  def country?(user)

    list = []
    country_list.each do |country|
      list.push IsoCountryCodes.search_by_name(country)[0].alpha2
    end

    country_list.blank? || (user.country.present? && list.include?(user.country))
  end

  def race?(user)
    race_list.blank? || (user.race.present? && race_list.include?(user.race))
  end

  def categories?(user)
    category_list.blank? || 
      (user.main_interest.present? && category_list.include?(user.main_interest)) || 
      (user.secondary_interest_list.present? && allow_interest? && 
        user.secondary_interest_list.any? { |interest| category_list.include?(interest) })
  end
end