class User < ActiveRecord::Base
  include User::UpdateActions

  authenticates_with_sorcery!

  after_initialize :set_default_password, if: :new_record?
  before_validation :set_default_email, if: :new_record?

  enum role: [:user, :superadmin, :admin, :banned]
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
  validates_size_of :image, maximum: 5.megabytes, messaage: 'should be less than 5MB'

  acts_as_taggable_on :primary_interests, :secondary_interests

  has_many :authentications, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :reward_transactions
  has_one :user_image, dependent: :destroy
  has_one :social_score, dependent: :destroy
  accepts_nested_attributes_for :authentications

  mount_uploader :image, ImageUploader

  # Move to concerns
  scope :admin_order, ->(attr, direction) {
    Admin::SortUsers.new(attr, direction).scope
  }

  def interest_not_selected?
    primary_interest_list.empty?
  end

  private

  def correct_user_birthday
    begin
      return if DateTime.parse(birthday.to_s) && birthday <= Date.today
    rescue
    end
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
