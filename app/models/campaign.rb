class Campaign < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score, :max_socialite_score

  has_many :posts
  has_many :tasks
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :tasks, reject_if: proc { |a| a['posts'].blank? || 
                                                              a['comments'].blank? || 
                                                              a['likes'].blank? }, allow_destroy: true

  def self.targeted_at(user)
    all.select do |campaign|
      campaign.targeted_at?(user)
    end
  end
  #write tests!!
  def targeted_at?(user)
    show = true
    conditions = [min_age?(user), max_age?(user), min_socialite_score?(user), 
                  max_socialite_score?(user), religion?(user), country?(user), 
                  race?(user), categories?(user)]
  

    conditions.each do |condition|
      if show == false
        break
      elsif condition == false
        show = false
      end
    end

    show
  end

  def min_age?(user)
    if min_age.present? 
      if user.age.present?
        user.age >= min_age.to_i
      else
        false
      end
    else
      true
    end
  end

  def max_age?(user)
    if max_age.present?
      if user.age.present?
        user.age <= max_age.to_i
      else
        false
      end
    else
      true
    end
  end

  def min_socialite_score?(user)
    if min_socialite_score.present?
      if user.socialite_score.present?
        user.socialite_score.to_i >= min_socialite_score.to_i
      else
        false
      end
    else
      true
    end
  end

  def max_socialite_score?(user)
    if max_socialite_score.present?
      if user.socialite_score.present?
        user.socialite_score.to_i <= max_socialite_score.to_i
      else
        false
      end
    else
      true
    end
  end

  def religion?(user)
    if religion_list.present?
      if user.religion.present?
        religion_list.include?(user.religion)
      else
        false
      end
    else
      true
    end
  end

  def country?(user)
    list = []

    if country_list.present?
      if user.country.present?
        country_list.each do |country|
          list.push IsoCountryCodes.search_by_name(country)[0].alpha2
        end
        
        list.include?(user.country)
      else
        false
      end
    else
      true
    end
  end

  def race?(user)

    if race_list.present?
      if user.race.present?
        race_list.include?(user.race)
      else
        false
      end
    else
      true
    end
  end

  def categories?(user)
    if category_list.present?
      if user.main_interest.present?
        if category_list.include?(user.main_interest)
          true
        elsif user.secondary_interest_list.present? && allow_interest?
          user.secondary_interest_list.any? { |interest| category_list.include?(interest) }
        else
          false
        end
      elsif user.secondary_interest_list.present? && allow_interest?
        user.secondary_interest_list.any? { |interest| category_list.include?(interest) }
      else
        false
      end
    else
      true
    end
  end
end
