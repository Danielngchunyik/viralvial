class UserImage < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  mount_uploader :storage, ImageUploader
end
