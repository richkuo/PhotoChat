class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :event_id
      t.integer :uploader_id

      t.timestamps
    end

    add_index :invitations, :event_id
    add_index :invitations, :uploader_id
    add_index :invitations, [:event_id, :uploader_id], unique: true

  end
end
