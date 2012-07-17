class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :viewer_id
      t.integer :uploader_id
      t.integer :request_id

      t.timestamps
    end

    add_index :invitations, :viewer_id
    add_index :invitations, :uploader_id
    add_index :invitations, [:viewer_id, :uploader_id], unique: true

  end
end
