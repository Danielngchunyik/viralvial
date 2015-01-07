class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  include Campaigns::Invitations
  extend Campaigns::Filters::ClassMethods
  extend Campaigns::Invitations::ClassMethods

  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries, :marital_status
  acts_as_taggable_on :invitations, :username

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score, :max_socialite_score, :language

  has_many :posts
  has_many :topics
  validates_presence_of :title
  validates_presence_of :description
  enum language: [:unspecified, :chinese, :english, :malay]

  accepts_nested_attributes_for :topics

  def save
    saved = false
    ActiveRecord::Base.transaction do
      saved = super
      if self.topics.size < 1
        saved = false
        errors[:base] << "You need to have at least one topic."
        raise ActiveRecord::Rollback
      end
    end
    saved
  end
end
