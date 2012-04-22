class AddEventsToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :iss_event, :boolean, :default => true
    add_column :subscribers, :iridium_event, :boolean, :default => true
    drop_table :events_subscribers
  end
end
