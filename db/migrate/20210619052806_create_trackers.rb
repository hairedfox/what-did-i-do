class CreateTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :trackers do |t|
      t.string :tracker_type
      t.datetime :occurred_at, index: true
      t.integer :times, default: 0
      t.references :user_activity, foreign_key: true, index: true

      t.timestamps
    end
  end
end
