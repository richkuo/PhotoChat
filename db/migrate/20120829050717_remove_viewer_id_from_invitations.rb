class RemoveViewerIdFromInvitations < ActiveRecord::Migration
  def up
    remove_column :invitations, :viewer_id
  end

  def down
    add_column :invitations, :viewer_id, :integer
  end
end
