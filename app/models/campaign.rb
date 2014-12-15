class Campaign < ActiveRecord::Base
  include Campaigns::Filters
  extend Campaigns::Filters::ClassMethods

  acts_as_taggable
  acts_as_taggable_on :categories, :religions, :races, :countries

  store_accessor :criteria, :min_age, :max_age, :min_socialite_score, :max_socialite_score

  has_many :posts
  has_many :tasks
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :tasks, reject_if: proc { |a| a['posts'].blank? || 
                                                              a['comments'].blank? || 
                                                              a['likes'].blank? }, allow_destroy: true

end
