class ChangeEventSubscribersToString < ActiveRecord::Migration
  def up
    drop_table :events
    change_column(:events_subscribers, :event_id, :string)
    rename_column(:events_subscribers, :event_id, :event)
  end

  def down
    rename_column :events_subscribers, :event, :event_id
    change_column :events_subscribers, :event_id, :integer
  end
end
