class Picture < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :image, :remote_image_url

  belongs_to :event

  mount_uploader :image, ImageUploader




end
