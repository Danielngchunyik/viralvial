class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  include Campaigns::Invitations
  extend Campaigns::Filters::ClassMethods
  extend Campaigns::Invitations::ClassMethods

  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries,
                      :marital_status
  acts_as_taggable_on :invitations, :username

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score,
                 :max_socialite_score, :language

  has_many :topics
  validates :title, :description, presence: true
  validate :at_least_one_topic_required
  enum language: [:unspecified, :chinese, :english, :malay]

  accepts_nested_attributes_for :topics, allow_destroy: true

  private

  def at_least_one_topic_required
    return if topics.exists?
    errors.add(:topic, 'is missing. At least one topic is required.')
  end
end
