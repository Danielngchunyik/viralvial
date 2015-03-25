class User < ActiveRecord::Base

  store_accessor :scores, :viral_vial_score
  store_accessor :followers, :facebook_followers, :twitter_followers, :total_followers

  authenticates_with_sorcery!

  after_initialize :set_default_password, if: :new_record?
  after_initialize :set_default_follower_count, if: :new_record?
  before_validation :set_default_email, if: :new_record?
  after_commit :update_social_scores, on: :create
  after_save :tally_total_followers, if: :followers_changed?

  enum role: [:user, :admin, :banned]
  enum gender: [:unspecified, :female, :male]
  enum race: [:chinese, :indian, :malay, :others]

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, length: { minimum: 8 }, if: :password
  validates :password, confirmation: true, if: :password
  validates :password_confirmation, presence: true, if: :password
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validate :correct_user_birthday

  acts_as_taggable_on :primary_interests
  acts_as_taggable_on :secondary_interests

  has_many :authentications, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :user_image, dependent: :destroy
  accepts_nested_attributes_for :authentications

  mount_uploader :image, ImageUploader

  def interest_not_selected?
    primary_interest_list.empty?
  end
   
  def set_access_token(access_token, provider)
    auth = self.authentications.find_by(provider: provider)
    auth.update(token: access_token.try(:token), secret: access_token.try(:secret))
  end

  def has_linked_provider?(provider)
    authentications.where(provider: provider).present?
  end
  
  def main_interest=(value)
    self.primary_interest_list = value
  end

  def birthday_day=(value)
    self.birthday = birthday.change(day: value.to_i)
  end

  def birthday_month=(value)
    self.birthday = birthday.change(month: value.to_i)
  end

  def birthday_year=(value)
    self.birthday = birthday.change(year: value.to_i)
  end

  def update_followers
    ["facebook", "twitter"].each do |provider|  
      fetch_and_save_new_follower_count(provider)
    end
  end

  private

  def tally_total_followers
    self.update(total_followers: self.facebook_followers.to_i + self.twitter_followers.to_i)
  end

  def followers_changed?
    new_total_count = self.facebook_followers.to_i + self.twitter_followers.to_i
    
    new_total_count != self.total_followers.to_i
  end

  def fetch_and_save_new_follower_count(provider)
    return unless auth = authentications.find_by(provider: provider)
    access_token = AccessToken.new(auth.try(:token), auth.try(:secret))

    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo".constantize
    klass.new(access_token, nil, self).update_followers
  end

  def update_social_scores
    ScoresWorker.perform_async
  end

  def set_default_follower_count
    self.facebook_followers = 0 if self.facebook_followers.nil?
    self.twitter_followers = 0 if self.twitter_followers.nil?
    self.total_followers = 0 if self.total_followers.nil?
  end
  
  def correct_user_birthday
    return if DateTime.parse(birthday.to_s) && birthday <= Date.today
    errors.add(:birthday, 'is invalid')
  rescue
    errors.add(:birthday, 'is invalid')
  end

  def set_default_email
    return unless self.email.nil?
    self.email = loop do
      email = "#{SecureRandom.urlsafe_base64}@changeme.com"
      break email unless User.where(email: email).exists?
    end
  end

  def set_default_password
    return unless self.password.nil?
    password = SecureRandom.hex
    self.password = password
    self.password_confirmation = password
  end
end
