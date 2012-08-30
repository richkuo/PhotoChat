class RemoveRequestIdFromInvitations < ActiveRecord::Migration
  def up
    remove_column :invitations, :request_id
  end

  def down
    add_column :invitations, :request_id, :integer
  end
end
