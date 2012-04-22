class AddZoneToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :zone, :string
  end
end
