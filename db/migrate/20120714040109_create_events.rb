class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.integer :host_id
      t.boolean :private

      t.timestamps
    end

    add_index :events, [:host_id, :created_at]

  end
end
