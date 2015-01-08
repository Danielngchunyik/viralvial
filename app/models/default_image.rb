class DefaultImage < ActiveRecord::Base
  belongs_to :topic

  mount_uploader :storage, ImageUploader
  validates :storage, presence: true
end
