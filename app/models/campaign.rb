class Campaign < ActiveRecord::Base
  acts_as_taggable_on :categories

  has_many :posts
  has_many :tasks

  mount_uploader :image, ImageUploader
end
