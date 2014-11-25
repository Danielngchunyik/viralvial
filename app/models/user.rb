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

  private

  def set_default_password
    return unless self.password.nil?
    password = SecureRandom.hex
    self.password = password
    self.password_confirmation = password
  end
end
