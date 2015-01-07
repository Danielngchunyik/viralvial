class DefaultImage < ActiveRecord::Base
  belongs_to :campaign

  mount_uploader :storage, ImageUploader
end
