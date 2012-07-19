class Event < ActiveRecord::Base
  attr_accessible :title, :description
  belongs_to :user

  has_many :pictures

  has_many :invitations, foreign_key: "uploader_id", dependent: :destroy

  has_many :uploaders, through: :invitations, source: :uploader

  validates :description, length: { maximum: 200 }
  validates :host_id, presence: true

  default_scope order: 'events.created_at DESC'

  def feed
  end

  def host?
    current_user.id == event.host_id
  end

  def uploader?(other_user)
    invitations.find_by_uploader_id(other_user.id)
  end

  def add_uploader!(other_user)
    invitations.create!(uploader_id: other_user.id)
  end

  def remove_uploader!(other_user)
    invitations.find_by_uploader_id(other_user.id).destroy
  end

  def viewer?(other_user)
  end

  def add_viewer!(other_user)
    invitations.create!(viewer_id: other_user.id)
  end

  def remove_viewer!(other_user)
    invitations.find_by_viewer_id(other_user.id).destroy
  end


end
