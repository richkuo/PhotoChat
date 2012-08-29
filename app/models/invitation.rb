class Invitation < ActiveRecord::Base
  attr_accessible :uploader_id, :event_id

  belongs_to :uploader, class_name: "User"
  belongs_to :event

  validates :uploader_id, presence: true
  validates :event_id, presence: true


end
