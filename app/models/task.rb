class Task < ActiveRecord::Base
  belongs_to :campaign
  has_many :posts

  enum social_media_platform: [:facebook]
end
