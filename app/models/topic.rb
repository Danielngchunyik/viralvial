class Topic < ActiveRecord::Base
  belongs_to :campaign
  has_many :posts

  validates_presence_of :description
  enum social_media_platform: [:facebook, :twitter]
end
