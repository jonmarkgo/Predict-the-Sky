class CreateSubscribersEvents < ActiveRecord::Migration
  def change
    create_table :subscribers_events do |t|
      t.integer :subscriber_id
      t.integer :event_id

      t.timestamps
    end
  end
end
