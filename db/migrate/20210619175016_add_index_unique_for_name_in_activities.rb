class AddIndexUniqueForNameInActivities < ActiveRecord::Migration[6.1]
  def change
    add_index :activities, :name, unique: true
  end
end
