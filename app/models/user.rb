class User < ActiveRecord::Base
  store_accessor :scores, :followers, :klout, :localization, :reach_score,
                 :sx_index, :influence_score, :socialite_score, :karma

  authenticates_with_sorcery!
  after_initialize :set_default_password, if: :new_record?
  after_commit :update_social_scores, on: :create

  enum role: [:user, :admin, :banned]
  enum gender: [:unspecified, :female, :male]

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :password, length: { minimum: 8 }, if: :password
  validates :password, confirmation: true, if: :password
  validates :password_confirmation, presence: true, if: :password
  validates :email, uniqueness: true

  acts_as_taggable_on :specializations, :interests

  has_many :authentications, dependent: :destroy
  has_many :posts
  accepts_nested_attributes_for :authentications

  mount_uploader :image, ImageUploader

  def set_access_token(token, provider)
    auth = self.authentications.find_by(provider: provider)
    auth.update(token: token)
  end

  def sync_with_facebook!
    fb_user = FbGraph::User.fetch("me?access_token=#{@token}")
    # OPTIMIZE: use @user.save in the future
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    location_array = fb_user.location.name.split(', ')
    self.update(birthday: fb_user.birthday,
                location: location_array[0],
                country: IsoCountryCodes.search_by_name(location_array[1])[0].alpha2)

  #For campaign filters
  def age
    birthday && ((Date.today - birthday) / 365.25)
  end

  def update_password_and_email(current_password, new_email, new_password, new_password_confirmation)
    if User.authenticate(self.email, current_password).present?
      self.password_confirmation = new_password_confirmation
      self.update(email: new_email)
      self.change_password!(new_password)
    end
  end

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
