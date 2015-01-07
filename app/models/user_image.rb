class UserImage < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  mount_uploader :storage, ImageUploader
end
