class AddNotesToUserActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :user_activities, :notes, :string
  end
end
