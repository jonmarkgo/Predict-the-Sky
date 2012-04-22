require File.expand_path('../../../config/environment', __FILE__)
require File.expand_path('../../../app/models/iss_event', __FILE__)
require File.expand_path('../../../app/models/iridium_event', __FILE__)
require File.expand_path('../../../app/models/subscriber', __FILE__)

desc "This task is called by the Heroku scheduler add-on and checks all of our events to see who to notify"
task :check_events do
  puts "Starting events check"

  IssEvent.scan_for_subscriber
  IridiumEvent.scan_for_subscriber

  puts "Finished with events check"
end
