class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :phonenumber
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
