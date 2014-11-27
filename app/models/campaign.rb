class Campaign < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :tasks
end