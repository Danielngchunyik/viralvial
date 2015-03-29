class UserImage < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  mount_uploader :storage, ImageUploader
  validates :storage, presence: true
  validates_integrity_of :storage
  validates_size_of :storage, maximum: 5.megabytes, messaage: 'should be less than 5MB'
end
