class AddStartDateToUserActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :user_activities, :start_date, :datetime
  end
end
