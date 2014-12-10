class Campaign < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :posts
  has_many :tasks
  has_many :images, dependent: :destroy

  serialize :criteria

  def self.targeted_at(user)
    all.select do |campaign|
      campaign.targeted_at?(user)
    end
  end
  
  # age = 25
  # location = Kuala Lumpur
  #{age: 25, location: 'Kuala Lumpur'}
  #{gender: 'male', country: 'Poland', min_age: , max_age:, continent: 'Europe', min_klout_score: 70}
  
  accepts_nested_attributes_for :images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :tasks, reject_if: proc { |a| a['posts'].blank? || 
                                                              a['comments'].blank? || 
                                                              a['likes'].blank? }, allow_destroy: true

  def criteria_min_age
    criteria && criteria[:min_age]
  end

  def criteria_min_age=(value)
    criteria[:min_age] = value.to_i
  end

  #write tests!!
  def targeted_at?(user)
    if criteria_min_age.present? && user.age.present?
      user.age >= criteria_min_age
    else
      true
    end
  end
end
