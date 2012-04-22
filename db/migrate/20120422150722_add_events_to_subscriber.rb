class AddEventsToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :iss_event, :boolean, :default => 1
    add_column :subscribers, :iridium_event, :boolean, :default => 1
    drop_table :events_subscribers
  end
end
