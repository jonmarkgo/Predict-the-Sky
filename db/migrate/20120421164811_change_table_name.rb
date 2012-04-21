class ChangeTableName < ActiveRecord::Migration
  def up
    rename_table :subscribers_events, :events_subscribers
  end

  def down
    rename_table :events_subscribers, :subscribers_events
  end
end
