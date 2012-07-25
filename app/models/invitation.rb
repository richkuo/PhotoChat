class Invitation < ActiveRecord::Base
  attr_accessible :uploader_id, :viewer_id

  belongs_to :uploader, class_name: "Event"

  validates :uploader_id, presence: true


end
