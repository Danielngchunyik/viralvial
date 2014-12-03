class Campaign < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :posts
  has_many :tasks
  has_many :images, dependent: :destroy
  
  accepts_nested_attributes_for :images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true

end
