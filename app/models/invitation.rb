class Invitation < ActiveRecord::Base
# Class is used to keep track of uploaders in an event
  attr_accessible :uploader_id, :event_id

  belongs_to :uploader, class_name: "User"
  
  belongs_to :event

  validates :uploader_id, presence: true
  
  validates :event_id, presence: true

end
