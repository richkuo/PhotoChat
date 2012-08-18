class Picture < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :image, :remote_image_url

  belongs_to :event

  mount_uploader :image, ImageUploader


  def to_jq_upload
    {
      "name" => read_attribute(:avatar),
      "size" => avatar.size,
      "url" => avatar.url,
      "thumbnail_url" => avatar.thumb.url,
      "delete_url" => picture_path(:id => id),
      "delete_type" => "DELETE"
    }
  end



end
