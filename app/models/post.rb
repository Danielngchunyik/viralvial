class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user

  mount_uploader :image, ImageUploader
end
