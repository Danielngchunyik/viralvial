class User < ActiveRecord::Base

  store_accessor :scores, :followers, :klout, :localization, :reach_score, :sx_index, :influence_score, :socialite_score, :karma

  authenticates_with_sorcery!
  after_initialize :set_default_password, if: :new_record?
  after_create :update_social_scores

  enum role: [:user, :admin, :banned]
  enum gender: [:female, :male]

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, length: { minimum: 8 }, if: :password
  validates :password, confirmation: true, if: :password
  validates :password_confirmation, presence: true, if: :password
  validates :email, uniqueness: true

  acts_as_taggable_on :specializations, :interests

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  private

  def update_social_scores
    ScoresWorker.perform_async
  end

  def set_default_password
    return unless self.password.nil?
    password = SecureRandom.hex
    self.password = password
    self.password_confirmation = password
  end

end
