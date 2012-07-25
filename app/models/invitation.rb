class Invitation < ActiveRecord::Base
  attr_accessible :uploader_id, :viewer_id

  belongs_to :uploader, class_name: "Event"
  belongs_to :viewer, class_name: "Event"

  validates :uploader_id, presence: true
  validates :viewer_id, presence: true


end
