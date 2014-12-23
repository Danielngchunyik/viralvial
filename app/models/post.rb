class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  belongs_to :topic

  mount_uploader :image, ImageUploader
end
