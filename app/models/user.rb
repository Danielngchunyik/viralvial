class User < ActiveRecord::Base

  store_accessor :viral_vial_score, :total_followers

  authenticates_with_sorcery!
  after_initialize :set_default_password, if: :new_record?
  before_validation :set_default_email, if: :new_record?
  after_commit :update_social_scores, on: :create

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
  has_many :followers, dependent: :destroy
  accepts_nested_attributes_for :authentications

  mount_uploader :image, ImageUploader

   
  def set_access_token(token, provider, secret=nil)
    auth = self.authentications.find_by(provider: provider)
    auth.update(token: token, secret: secret)
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

  private

  def update_social_scores
    ScoresWorker.perform_async
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
