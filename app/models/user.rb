class User < ActiveRecord::Base
  authenticates_with_sorcery!
  after_initialize :set_default_password, :set_default_role, :if => :new_record?

  enum role: [:banned, :user, :admin]

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

  def set_default_role
    self.role ||= :user
  end
end
