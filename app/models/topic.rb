class Topic < ActiveRecord::Base
  belongs_to :campaign
  has_many :default_images, dependent: :destroy
  has_many :user_images, dependent: :destroy
  has_many :posts

  validates_presence_of :description
  enum social_media_platform: [:facebook, :twitter]

  accepts_nested_attributes_for :default_images, reject_if: proc { |a| a['storage'].blank? }, allow_destroy: true
end
