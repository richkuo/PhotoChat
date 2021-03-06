class Event < ActiveRecord::Base
  attr_accessible :title, :description
  
  has_one :host, class_name: "User"

  has_many :invitations, foreign_key: "event_id", dependent: :destroy

  has_many :uploaders, through: :invitations, source: :uploader

  has_many :pictures

  has_many :comments, as: :commentable

  validates :description, length: { maximum: 250 }
 
  validates :host_id, presence: true

  # Not sure if this would be good for UX
  # default_scope order: 'events.created_at DESC'
  
  def add_uploader!(other_user)
    invitations.create!(uploader_id: other_user.id)
  end

  def remove_uploader!(other_user)
    invitations.find_by_uploader_id(other_user.id).destroy
  end

  def uploader?(other_user)
    invitations.find_by_uploader_id(other_user.id)
  end

end
