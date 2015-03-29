class DefaultImage < ActiveRecord::Base
  belongs_to :topic

  mount_uploader :storage, ImageUploader
  validates :storage, presence: true
  validates_size_of :storage, maximum: 5.megabytes, messaage: 'should be less than 5MB'
end
