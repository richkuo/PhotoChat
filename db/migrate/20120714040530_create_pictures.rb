class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end

    add_index :pictures, [:user_id, :created_at]

  end
end
