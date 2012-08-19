class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  attr_accessible :event_id, :user_id, :image, :remote_image_url

  belongs_to :event

  mount_uploader :image, ImageUploader

  has_many :images

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      #"delete_url" => picture_path(:id => id),
      "delete_type" => "DELETE"
    }
  end



end
