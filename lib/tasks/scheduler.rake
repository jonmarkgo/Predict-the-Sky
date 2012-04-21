require File.expand_path('../../../config/environment', __FILE__)
require File.expand_path('../../../app/models/iss_event', __FILE__)
require File.expand_path('../../../app/models/subscriber', __FILE__)

desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
  puts "Checking satellites and shit"

  Event.descendants.each do |event|
    event.scan_for_subscriber
  end
  puts "done."
end