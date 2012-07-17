class Event < ActiveRecord::Base
  attr_accessible :title, :description
  belongs_to :user

  has_many :pictures

  validates :description, length: { maximum: 200 }
  validates :host_id, presence: true

  default_scope order: 'events.created_at DESC'

end
