class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  include Campaigns::Invitation
  extend Campaigns::Filters::ClassMethods
  extend Campaigns::Invitation::ClassMethods

  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries, :marital_status
  acts_as_taggable_on :invitations, :username

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score, :max_socialite_score, :language

  has_many :posts
  has_many :topics
  has_many :images, dependent: :destroy
  validates_presence_of :title
  validates_presence_of :description
  enum language: [:chinese, :english, :malay]

  accepts_nested_attributes_for :images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :topics
end
