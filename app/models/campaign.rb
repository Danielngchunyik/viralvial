class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  include Campaigns::Invitations
  extend Campaigns::Filters::ClassMethods
  extend Campaigns::Invitations::ClassMethods

  acts_as_taggable_on :categories, :invitations
  store_accessor :criteria

  has_many :topics
  has_many :posts
  has_many :reward_transactions
  validates :title, :description, presence: true
  validate :at_least_one_topic_required
  validates_size_of :image, maximum: 5.megabytes, messaage: 'should be less than 5MB'
  validates_size_of :banner, maximum: 5.megabytes, messaage: 'should be less than 5MB'

  enum language: [:unspecified, :chinese, :english, :malay]

  accepts_nested_attributes_for :topics, allow_destroy: true
  mount_uploader :image, ImageUploader
  mount_uploader :banner, ImageUploader
  
  def at_least_one_topic_required
    return if topics.present?
    errors.add(:topic, 'is missing. At least one topic is required.')
  end
end
