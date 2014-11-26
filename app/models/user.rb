class User < ActiveRecord::Base

  store_accessor :scores, :followers, :klout, :localization, :reach_score, :sx_index, :influence_score, :socialite_score, :karma

  authenticates_with_sorcery!
  after_initialize :set_default_password, if: :new_record?
  after_initialize :set_social_scores

  enum role: [:user, :admin, :banned]
  enum gender: [:female, :male]

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true

  acts_as_taggable_on :specializations, :interests

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  private

  # TODO: Background worker
  def set_social_scores
    #get user followers percentile
    total_followers ||= User.pluck("(scores -> 'followers')::integer")
    less_followers = []
    same_followers = []

    total_followers.each do |tf|
      if tf < self.followers.to_i
        less_followers.push(tf)
      elsif tf == self.followers.to_i
        same_followers.push(tf)
      end
    end

    #set reach_score
    self.reach_score ||= ((less_followers.length + (0.5 * same_followers.length))/total_followers.length * 100).round(2)
    
    #set sx_index
    self.sx_index ||= ((self.localization.to_f + self.reach_score.to_f)/200*100).round(2)
    
    #set_influence_score
    self.influence_score ||= ((self.klout.to_f + self.sx_index.to_f)/200*100).round(2)

    #set_socialite_score
    self.socialite_score ||= (self.influence_score.to_f + self.karma.to_f).round(2)
  end

  def set_default_password
    return unless self.password.nil?
    password = SecureRandom.hex
    self.password = password
    self.password_confirmation = password
  end

end
