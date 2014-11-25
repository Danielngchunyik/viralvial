class User < ActiveRecord::Base

  store_accessor :scores, :followers, :klout, :localization, :karma

  authenticates_with_sorcery!
  after_initialize :set_default_password, if: :new_record?

  enum role: [:user, :admin, :banned]

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

  def reach_score
    return @reach_score unless @reach_score.nil?
    less_followers = []
    same_followers = []

    total_followers.each do |tf|
      if tf < self.followers.to_i
        less_followers.push(tf)
      elsif tf == self.followers.to_i
        same_followers.push(tf)
      end
    end
    @reach_score = ((less_followers.length + (0.5 * same_followers.length))/total_followers.length * 100).round(2)
  end

  def sx_index
    @sx_index ||= ((self.localization.to_i + reach_score)/200*100).round(2)
  end

  def influence_score
    @influence_score ||= ((self.klout.to_i + sx_index)/200*100).round(2)
  end

  def socialite_score
    @socialite_score ||= (influence_score + self.karma.to_i).round(2)
  end

  private

  def total_followers
    @total_followers ||= User.pluck("(scores -> 'followers')::integer")
  end

  def set_default_password
    return unless self.password.nil?
    password = SecureRandom.hex
    self.password = password
    self.password_confirmation = password
  end

end
